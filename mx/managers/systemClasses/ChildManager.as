package mx.managers.systemClasses
{
   import mx.managers.ISystemManagerChildManager;
   import mx.core.mx_internal;
   import mx.managers.ISystemManager;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import mx.managers.ILayoutManagerClient;
   import mx.core.IUIComponent;
   import mx.core.IFlexModule;
   import mx.core.IFontContextComponent;
   import mx.core.UIComponent;
   import flash.display.InteractiveObject;
   import mx.styles.IStyleClient;
   import mx.styles.ISimpleStyleClient;
   import mx.events.FlexEvent;
   import flash.events.IEventDispatcher;
   import mx.messaging.config.LoaderConfig;
   import mx.utils.LoaderUtil;
   import mx.core.IFlexDisplayObject;
   import mx.core.IInvalidating;
   import mx.preloaders.Preloader;
   import mx.core.IFlexModuleFactory;

   use namespace mx_internal;

   public class ChildManager extends Object implements ISystemManagerChildManager
   {
      public function ChildManager(param1:IFlexModuleFactory) {
         super();
         if(param1  is  ISystemManager)
         {
            param1["childManager"]=this;
            this.systemManager=ISystemManager(param1);
            this.systemManager.registerImplementation("mx.managers::ISystemManagerChildManager",this);
         }
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      private var systemManager:ISystemManager;

      public function addingChild(param1:DisplayObject) : void {
         var _loc3_:DisplayObjectContainer = null;
         var _loc2_:* = 1;
         if(!this.topLevel && (DisplayObject(this.systemManager).parent))
         {
            _loc3_=DisplayObject(this.systemManager).parent.parent;
            while(_loc3_)
            {
               if(_loc3_  is  ILayoutManagerClient)
               {
                  _loc2_=ILayoutManagerClient(_loc3_).nestLevel + 1;
                  break;
               }
               _loc3_=_loc3_.parent;
            }
         }
         this.nestLevel=_loc2_;
         if(param1  is  IUIComponent)
         {
            IUIComponent(param1).systemManager=this.systemManager;
         }
         if(param1  is  IUIComponent && !IUIComponent(param1).document)
         {
            IUIComponent(param1).document=this.systemManager.document;
         }
         if(param1  is  IFlexModule && IFlexModule(param1).moduleFactory == null)
         {
            IFlexModule(param1).moduleFactory=this.systemManager;
         }
         if(param1  is  IFontContextComponent && !param1  is  UIComponent && IFontContextComponent(param1).fontContext == null)
         {
            IFontContextComponent(param1).fontContext=this.systemManager;
         }
         if(param1  is  ILayoutManagerClient)
         {
            ILayoutManagerClient(param1).nestLevel=this.nestLevel + 1;
         }
         if(param1  is  InteractiveObject)
         {
            if(InteractiveObject(this.systemManager).doubleClickEnabled)
            {
               InteractiveObject(param1).doubleClickEnabled=true;
            }
         }
         if(param1  is  IUIComponent)
         {
            IUIComponent(param1).parentChanged(DisplayObjectContainer(this.systemManager));
         }
         if(param1  is  IStyleClient)
         {
            IStyleClient(param1).regenerateStyleCache(true);
         }
         if(param1  is  ISimpleStyleClient)
         {
            ISimpleStyleClient(param1).styleChanged(null);
         }
         if(param1  is  IStyleClient)
         {
            IStyleClient(param1).notifyStyleChangeInChildren(null,true);
         }
         if(param1  is  UIComponent)
         {
            UIComponent(param1).initThemeColor();
         }
         if(param1  is  UIComponent)
         {
            UIComponent(param1).stylesInitialized();
         }
         return;
      }

      public function childAdded(param1:DisplayObject) : void {
         if(param1.hasEventListener(FlexEvent.ADD))
         {
            param1.dispatchEvent(new FlexEvent(FlexEvent.ADD));
         }
         if(param1  is  IUIComponent)
         {
            IUIComponent(param1).initialize();
         }
         return;
      }

      public function removingChild(param1:DisplayObject) : void {
         if(param1.hasEventListener(FlexEvent.REMOVE))
         {
            param1.dispatchEvent(new FlexEvent(FlexEvent.REMOVE));
         }
         return;
      }

      public function childRemoved(param1:DisplayObject) : void {
         if(param1  is  IUIComponent)
         {
            IUIComponent(param1).parentChanged(null);
         }
         return;
      }

      public function regenerateStyleCache(param1:Boolean) : void {
         var _loc5_:IStyleClient = null;
         var _loc2_:* = false;
         var _loc3_:int = this.systemManager.rawChildren.numChildren;
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_=this.systemManager.rawChildren.getChildAt(_loc4_) as IStyleClient;
            if(_loc5_)
            {
               _loc5_.regenerateStyleCache(param1);
            }
            if(this.isTopLevelWindow(DisplayObject(_loc5_)))
            {
               _loc2_=true;
            }
            _loc3_=this.systemManager.rawChildren.numChildren;
            _loc4_++;
         }
         if(this.topLevelWindow  is  IStyleClient)
         {
            IStyleClient(this.topLevelWindow).regenerateStyleCache(param1);
         }
         return;
      }

      public function notifyStyleChangeInChildren(param1:String, param2:Boolean) : void {
         var _loc6_:IStyleClient = null;
         var _loc3_:* = false;
         var _loc4_:int = this.systemManager.rawChildren.numChildren;
         var _loc5_:* = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_=this.systemManager.rawChildren.getChildAt(_loc5_) as IStyleClient;
            if(_loc6_)
            {
               _loc6_.styleChanged(param1);
               _loc6_.notifyStyleChangeInChildren(param1,param2);
            }
            if(this.isTopLevelWindow(DisplayObject(_loc6_)))
            {
               _loc3_=true;
            }
            _loc4_=this.systemManager.rawChildren.numChildren;
            _loc5_++;
         }
         if(this.topLevelWindow  is  IStyleClient)
         {
            IStyleClient(this.topLevelWindow).styleChanged(param1);
            IStyleClient(this.topLevelWindow).notifyStyleChangeInChildren(param1,param2);
         }
         return;
      }

      public function initializeTopLevelWindow(param1:Number, param2:Number) : void {
         var _loc3_:IUIComponent = null;
         this.systemManager.document=_loc3_=this.topLevelWindow=IUIComponent(this.systemManager.create());
         if(this.systemManager.document)
         {
            IEventDispatcher(_loc3_).addEventListener(FlexEvent.CREATION_COMPLETE,this.appCreationCompleteHandler);
            if(!LoaderConfig._url)
            {
               LoaderConfig._url=LoaderUtil.normalizeURL(this.systemManager.loaderInfo);
               LoaderConfig._parameters=this.systemManager.loaderInfo.parameters;
               LoaderConfig._swfVersion=this.systemManager.loaderInfo.swfVersion;
            }
            IFlexDisplayObject(_loc3_).setActualSize(param1,param2);
            if(this.preloader)
            {
               this.preloader.registerApplication(_loc3_);
            }
            this.addingChild(DisplayObject(_loc3_));
            this.childAdded(DisplayObject(_loc3_));
         }
         else
         {
            this.systemManager.document=this;
         }
         return;
      }

      private function appCreationCompleteHandler(param1:FlexEvent) : void {
         var _loc2_:DisplayObjectContainer = null;
         if(!this.topLevel && (DisplayObject(this.systemManager).parent))
         {
            _loc2_=DisplayObject(this.systemManager).parent.parent;
            while(_loc2_)
            {
               if(_loc2_  is  IInvalidating)
               {
                  IInvalidating(_loc2_).invalidateSize();
                  IInvalidating(_loc2_).invalidateDisplayList();
                  return;
               }
               _loc2_=_loc2_.parent;
            }
         }
         return;
      }

      private function isTopLevelWindow(param1:DisplayObject) : Boolean {
         return this.systemManager["isTopLevelWindow"](param1);
      }

      private function get topLevel() : Boolean {
         return this.systemManager["topLevel"];
      }

      private function set topLevel(param1:Boolean) : void {
         this.systemManager["topLevel"]=param1;
         return;
      }

      private function get topLevelWindow() : IUIComponent {
         return this.systemManager["topLevelWindow"];
      }

      private function set topLevelWindow(param1:IUIComponent) : void {
         this.systemManager["topLevelWindow"]=param1;
         return;
      }

      private function get nestLevel() : int {
         return this.systemManager["nestLevel"];
      }

      private function set nestLevel(param1:int) : void {
         this.systemManager["nestLevel"]=param1;
         return;
      }

      private function get preloader() : Preloader {
         return this.systemManager["preloader"];
      }

      private function set preloader(param1:Preloader) : void {
         this.systemManager["preloader"]=param1;
         return;
      }
   }

}