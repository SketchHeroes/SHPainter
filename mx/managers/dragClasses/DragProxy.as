package mx.managers.dragClasses
{
   import mx.core.UIComponent;
   import mx.core.mx_internal;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import mx.events.SandboxMouseEvent;
   import mx.styles.IStyleManager2;
   import mx.core.IFlexModule;
   import mx.styles.StyleManager;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.IEventDispatcher;
   import mx.core.IUIComponent;
   import mx.core.DragSource;
   import mx.styles.CSSStyleDeclaration;
   import mx.managers.DragManager;
   import mx.managers.CursorManager;
   import mx.events.DragEvent;
   import mx.events.InterManagerRequest;
   import mx.events.InterDragManagerEvent;
   import mx.managers.SystemManager;
   import flash.events.Event;
   import mx.effects.Move;
   import mx.effects.Zoom;
   import mx.managers.ISystemManager;
   import mx.events.EffectEvent;

   use namespace mx_internal;

   public class DragProxy extends UIComponent
   {
      public function DragProxy(param1:IUIComponent, param2:DragSource) {
         super();
         this.dragInitiator=param1;
         this.dragSource=param2;
         var _loc3_:ISystemManager = param1.systemManager.topLevelSystemManager as ISystemManager;
         var _loc4_:IEventDispatcher = this.sandboxRoot=_loc3_.getSandboxRoot();
         _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler,true);
         _loc4_.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler,true);
         _loc4_.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
         _loc4_.addEventListener(KeyboardEvent.KEY_UP,this.keyUpHandler);
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      private static function getObjectsUnderPoint(param1:DisplayObject, param2:Point, param3:Array) : void {
         var _loc4_:DisplayObjectContainer = null;
         var _loc5_:Object = null;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:DisplayObject = null;
         if(!param1.visible)
         {
            return;
         }
         if(param1  is  UIComponent && !UIComponent(param1).$visible)
         {
            return;
         }
         if(param1.hitTestPoint(param2.x,param2.y,true))
         {
            if(param1  is  InteractiveObject && (InteractiveObject(param1).mouseEnabled))
            {
               param3.push(param1);
            }
            if(param1  is  DisplayObjectContainer)
            {
               _loc4_=param1 as DisplayObjectContainer;
               if(_loc4_.mouseChildren)
               {
                  if("rawChildren"  in  _loc4_)
                  {
                     _loc5_=_loc4_["rawChildren"];
                     _loc6_=_loc5_.numChildren;
                     _loc7_=0;
                     while(_loc7_ < _loc6_)
                     {
                        try
                        {
                           getObjectsUnderPoint(_loc5_.getChildAt(_loc7_),param2,param3);
                        }
                        catch(e:Error)
                        {
                        }
                        _loc7_++;
                     }
                  }
                  else
                  {
                     if(_loc4_.numChildren)
                     {
                        _loc6_=_loc4_.numChildren;
                        _loc7_=0;
                        while(_loc7_ < _loc6_)
                        {
                           try
                           {
                              _loc8_=_loc4_.getChildAt(_loc7_);
                              getObjectsUnderPoint(_loc8_,param2,param3);
                           }
                           catch(e:Error)
                           {
                           }
                           _loc7_++;
                        }
                     }
                  }
               }
            }
         }
         return;
      }

      override public function initialize() : void {
         super.initialize();
         this.dragInitiator.systemManager.getSandboxRoot().addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE,this.mouseLeaveHandler);
         if(!getFocus())
         {
            setFocus();
         }
         return;
      }

      override public function get styleManager() : IStyleManager2 {
         if(this.dragInitiator  is  IFlexModule)
         {
            return StyleManager.getStyleManager(IFlexModule(this.dragInitiator).moduleFactory);
         }
         return super.styleManager;
      }

      private var cursorClass:Class = null;

      private var cursorID:int = 0;

      private var lastKeyEvent:KeyboardEvent;

      private var lastMouseEvent:MouseEvent;

      private var sandboxRoot:IEventDispatcher;

      public var dragInitiator:IUIComponent;

      public var dragSource:DragSource;

      public var xOffset:Number;

      public var yOffset:Number;

      public var startX:Number;

      public var startY:Number;

      public var target:DisplayObject = null;

      public var action:String;

      public var allowMove:Boolean = true;

      public function showFeedback() : void {
         var _loc1_:Class = this.cursorClass;
         var _loc2_:CSSStyleDeclaration = this.styleManager.getMergedStyleDeclaration("mx.managers.DragManager");
         if(this.action == DragManager.COPY)
         {
            _loc1_=_loc2_.getStyle("copyCursor");
         }
         else
         {
            if(this.action == DragManager.LINK)
            {
               _loc1_=_loc2_.getStyle("linkCursor");
            }
            else
            {
               if(this.action == DragManager.NONE)
               {
                  _loc1_=_loc2_.getStyle("rejectCursor");
               }
               else
               {
                  _loc1_=_loc2_.getStyle("moveCursor");
               }
            }
         }
         if(_loc1_ != this.cursorClass)
         {
            this.cursorClass=_loc1_;
            if(this.cursorID != CursorManager.NO_CURSOR)
            {
               cursorManager.removeCursor(this.cursorID);
            }
            this.cursorID=cursorManager.setCursor(this.cursorClass,2,0,0);
         }
         return;
      }

      public function checkKeyEvent(param1:KeyboardEvent) : void {
         var _loc2_:DragEvent = null;
         var _loc3_:Point = null;
         if(this.target)
         {
            if((this.lastKeyEvent) && (param1.type == this.lastKeyEvent.type) && param1.keyCode == this.lastKeyEvent.keyCode)
            {
               return;
            }
            this.lastKeyEvent=param1;
            _loc2_=new DragEvent(DragEvent.DRAG_OVER);
            _loc2_.dragInitiator=this.dragInitiator;
            _loc2_.dragSource=this.dragSource;
            _loc2_.action=this.action;
            _loc2_.ctrlKey=param1.ctrlKey;
            _loc2_.altKey=param1.altKey;
            _loc2_.shiftKey=param1.shiftKey;
            _loc3_=new Point();
            _loc3_.x=this.lastMouseEvent.localX;
            _loc3_.y=this.lastMouseEvent.localY;
            _loc3_=DisplayObject(this.lastMouseEvent.target).localToGlobal(_loc3_);
            _loc3_=DisplayObject(this.target).globalToLocal(_loc3_);
            _loc2_.localX=_loc3_.x;
            _loc2_.localY=_loc3_.y;
            this._dispatchDragEvent(this.target,_loc2_);
            this.showFeedback();
         }
         return;
      }

      override protected function keyDownHandler(param1:KeyboardEvent) : void {
         this.checkKeyEvent(param1);
         return;
      }

      override protected function keyUpHandler(param1:KeyboardEvent) : void {
         this.checkKeyEvent(param1);
         return;
      }

      public function stage_mouseMoveHandler(param1:MouseEvent) : void {
         if(param1.target != stage)
         {
            return;
         }
         this.mouseMoveHandler(param1);
         return;
      }

      private function dispatchDragEvent(param1:String, param2:MouseEvent, param3:Object) : void {
         var _loc4_:DragEvent = new DragEvent(param1);
         var _loc5_:Point = new Point();
         _loc4_.dragInitiator=this.dragInitiator;
         _loc4_.dragSource=this.dragSource;
         _loc4_.action=this.action;
         _loc4_.ctrlKey=param2.ctrlKey;
         _loc4_.altKey=param2.altKey;
         _loc4_.shiftKey=param2.shiftKey;
         _loc5_.x=this.lastMouseEvent.localX;
         _loc5_.y=this.lastMouseEvent.localY;
         _loc5_=DisplayObject(this.lastMouseEvent.target).localToGlobal(_loc5_);
         _loc5_=DisplayObject(param3).globalToLocal(_loc5_);
         _loc4_.localX=_loc5_.x;
         _loc4_.localY=_loc5_.y;
         this._dispatchDragEvent(DisplayObject(param3),_loc4_);
         return;
      }

      private function _dispatchDragEvent(param1:DisplayObject, param2:DragEvent) : void {
         var _loc3_:InterManagerRequest = null;
         var _loc4_:InterDragManagerEvent = null;
         if(this.isSameOrChildApplicationDomain(param1))
         {
            param1.dispatchEvent(param2);
         }
         else
         {
            _loc3_=new InterManagerRequest(InterManagerRequest.INIT_MANAGER_REQUEST);
            _loc3_.name="mx.managers::IDragManager";
            this.sandboxRoot.dispatchEvent(_loc3_);
            _loc4_=new InterDragManagerEvent(InterDragManagerEvent.DISPATCH_DRAG_EVENT,false,false,param2.localX,param2.localY,param2.relatedObject,param2.ctrlKey,param2.altKey,param2.shiftKey,param2.buttonDown,param2.delta,param1,param2.type,param2.dragInitiator,param2.dragSource,param2.action,param2.draggedItem);
            this.sandboxRoot.dispatchEvent(_loc4_);
         }
         return;
      }

      private function isSameOrChildApplicationDomain(param1:Object) : Boolean {
         var _loc2_:DisplayObject = SystemManager.getSWFRoot(param1);
         if(_loc2_)
         {
            return true;
         }
         var _loc3_:InterManagerRequest = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST);
         _loc3_.name="hasSWFBridges";
         this.sandboxRoot.dispatchEvent(_loc3_);
         if(!_loc3_.value)
         {
            return true;
         }
         return false;
      }

      public function mouseMoveHandler(param1:MouseEvent) : void {
         var _loc2_:DragEvent = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:* = 0;
         var _loc10_:Array = null;
         var _loc13_:* = false;
         var _loc14_:DisplayObject = null;
         this.lastMouseEvent=param1;
         var _loc5_:Point = new Point();
         var _loc6_:Point = new Point(param1.localX,param1.localY);
         var _loc7_:Point = DisplayObject(param1.target).localToGlobal(_loc6_);
         _loc6_=DisplayObject(this.sandboxRoot).globalToLocal(_loc7_);
         var _loc8_:Number = _loc6_.x;
         var _loc9_:Number = _loc6_.y;
         x=_loc8_ - this.xOffset;
         y=_loc9_ - this.yOffset;
         if(!param1)
         {
            return;
         }
         _loc10_=[];
         DragProxy.getObjectsUnderPoint(DisplayObject(this.sandboxRoot),_loc7_,_loc10_);
         var _loc11_:DisplayObject = null;
         var _loc12_:int = _loc10_.length-1;
         while(_loc12_ >= 0)
         {
            _loc11_=_loc10_[_loc12_];
            if(!(_loc11_ == this) && !contains(_loc11_))
            {
               break;
            }
            _loc12_--;
         }
         if(this.target)
         {
            _loc13_=false;
            _loc14_=this.target;
            _loc3_=_loc11_;
            while(_loc3_)
            {
               if(_loc3_ == this.target)
               {
                  this.dispatchDragEvent(DragEvent.DRAG_OVER,param1,_loc3_);
                  _loc13_=true;
                  break;
               }
               this.dispatchDragEvent(DragEvent.DRAG_ENTER,param1,_loc3_);
               if(this.target == _loc3_)
               {
                  _loc13_=false;
                  break;
               }
               _loc3_=_loc3_.parent;
            }
            if(!_loc13_)
            {
               this.dispatchDragEvent(DragEvent.DRAG_EXIT,param1,_loc14_);
               if(this.target == _loc14_)
               {
                  this.target=null;
               }
            }
         }
         if(!this.target)
         {
            this.action=DragManager.MOVE;
            _loc3_=_loc11_;
            while(_loc3_)
            {
               if(_loc3_ != this)
               {
                  this.dispatchDragEvent(DragEvent.DRAG_ENTER,param1,_loc3_);
                  if(this.target)
                  {
                     break;
                  }
               }
               _loc3_=_loc3_.parent;
            }
            if(!this.target)
            {
               this.action=DragManager.NONE;
            }
         }
         this.showFeedback();
         return;
      }

      public function mouseLeaveHandler(param1:Event) : void {
         this.mouseUpHandler(this.lastMouseEvent);
         return;
      }

      public function mouseUpHandler(param1:MouseEvent) : void {
         var _loc2_:DragEvent = null;
         var _loc6_:Point = null;
         var _loc7_:Move = null;
         var _loc8_:Zoom = null;
         var _loc9_:Move = null;
         var _loc3_:ISystemManager = this.dragInitiator.systemManager.topLevelSystemManager as ISystemManager;
         var _loc4_:IEventDispatcher = this.sandboxRoot;
         _loc4_.removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler,true);
         _loc4_.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler,true);
         _loc4_.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
         _loc4_.removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE,this.mouseLeaveHandler);
         _loc4_.removeEventListener(KeyboardEvent.KEY_UP,this.keyUpHandler);
         var _loc5_:Object = automationDelegate;
         if((this.target) && !(this.action == DragManager.NONE))
         {
            _loc2_=new DragEvent(DragEvent.DRAG_DROP);
            _loc2_.dragInitiator=this.dragInitiator;
            _loc2_.dragSource=this.dragSource;
            _loc2_.action=this.action;
            _loc2_.ctrlKey=param1.ctrlKey;
            _loc2_.altKey=param1.altKey;
            _loc2_.shiftKey=param1.shiftKey;
            _loc6_=new Point();
            _loc6_.x=this.lastMouseEvent.localX;
            _loc6_.y=this.lastMouseEvent.localY;
            _loc6_=DisplayObject(this.lastMouseEvent.target).localToGlobal(_loc6_);
            _loc6_=DisplayObject(this.target).globalToLocal(_loc6_);
            _loc2_.localX=_loc6_.x;
            _loc2_.localY=_loc6_.y;
            if(_loc5_)
            {
               _loc5_.recordAutomatableDragDrop(this.target,_loc2_);
            }
            this._dispatchDragEvent(this.target,_loc2_);
         }
         else
         {
            this.action=DragManager.NONE;
         }
         if(this.action == DragManager.NONE)
         {
            _loc7_=new Move(this);
            _loc7_.addEventListener(EffectEvent.EFFECT_END,this.effectEndHandler);
            _loc7_.xFrom=x;
            _loc7_.yFrom=y;
            _loc7_.xTo=this.startX;
            _loc7_.yTo=this.startY;
            _loc7_.duration=200;
            _loc7_.play();
         }
         else
         {
            _loc8_=new Zoom(this);
            _loc8_.zoomWidthFrom=_loc8_.zoomHeightFrom=1;
            _loc8_.zoomWidthTo=_loc8_.zoomHeightTo=0;
            _loc8_.duration=200;
            _loc8_.play();
            _loc9_=new Move(this);
            _loc9_.addEventListener(EffectEvent.EFFECT_END,this.effectEndHandler);
            _loc9_.xFrom=x;
            _loc9_.yFrom=y;
            _loc9_.xTo=parent.mouseX;
            _loc9_.yTo=parent.mouseY;
            _loc9_.duration=200;
            _loc9_.play();
         }
         _loc2_=new DragEvent(DragEvent.DRAG_COMPLETE);
         _loc2_.dragInitiator=this.dragInitiator;
         _loc2_.dragSource=this.dragSource;
         _loc2_.relatedObject=InteractiveObject(this.target);
         _loc2_.action=this.action;
         _loc2_.ctrlKey=param1.ctrlKey;
         _loc2_.altKey=param1.altKey;
         _loc2_.shiftKey=param1.shiftKey;
         this.dragInitiator.dispatchEvent(_loc2_);
         if((_loc5_) && this.action == DragManager.NONE)
         {
            _loc5_.recordAutomatableDragCancel(this.dragInitiator,_loc2_);
         }
         cursorManager.removeCursor(this.cursorID);
         this.cursorID=CursorManager.NO_CURSOR;
         this.lastMouseEvent=null;
         return;
      }

      private function effectEndHandler(param1:EffectEvent) : void {
         DragManager.endDrag();
         return;
      }
   }

}