package mx.core
{
   import mx.managers.ILayoutManager;
   import flash.display.InteractiveObject;
   import flash.geom.Matrix;

   use namespace mx_internal;

   public class UIComponentGlobals extends Object
   {
      public function UIComponentGlobals() {
         super();
         return;
      }

      mx_internal  static var layoutManager:ILayoutManager;

      mx_internal  static var callLaterSuspendCount:int = 0;

      mx_internal  static var callLaterDispatcherCount:int = 0;

      mx_internal  static var nextFocusObject:InteractiveObject;

      mx_internal  static var tempMatrix:Matrix = new Matrix();

      mx_internal  static var designTime:Boolean = false;

      public static function get designMode() : Boolean {
         return designTime;
      }

      public static function set designMode(param1:Boolean) : void {
         designTime=param1;
         return;
      }

      private static var _catchCallLaterExceptions:Boolean = false;

      public static function get catchCallLaterExceptions() : Boolean {
         return _catchCallLaterExceptions;
      }

      public static function set catchCallLaterExceptions(param1:Boolean) : void {
         _catchCallLaterExceptions=param1;
         return;
      }
   }

}