package mx.managers
{
   import flash.display.DisplayObject;
   import mx.effects.Effect;
   import flash.events.MouseEvent;
   import flash.events.Event;
   import flash.geom.Rectangle;


   public class PopUpData extends Object
   {
      public function PopUpData() {
         super();
         return;
      }

      public var owner:DisplayObject;

      public var parent:DisplayObject;

      public var topMost:Boolean;

      public var modalWindow:DisplayObject;

      public var _mouseDownOutsideHandler:Function;

      public var _mouseWheelOutsideHandler:Function;

      public var fade:Effect;

      public var blur:Effect;

      public var blurTarget:Object;

      public var systemManager:ISystemManager;

      public function mouseDownOutsideHandler(param1:MouseEvent) : void {
         this._mouseDownOutsideHandler(this.owner,param1);
         return;
      }

      public function mouseWheelOutsideHandler(param1:MouseEvent) : void {
         this._mouseWheelOutsideHandler(this.owner,param1);
         return;
      }

      public function resizeHandler(param1:Event) : void {
         var _loc2_:Rectangle = ISystemManager(param1.target).screen;
         if((this.modalWindow) && this.owner.stage == DisplayObject(param1.target).stage)
         {
            this.modalWindow.width=_loc2_.width;
            this.modalWindow.height=_loc2_.height;
            this.modalWindow.x=_loc2_.x;
            this.modalWindow.y=_loc2_.y;
         }
         return;
      }
   }

}