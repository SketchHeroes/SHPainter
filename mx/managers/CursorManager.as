package mx.managers
{
   import mx.core.mx_internal;
   import mx.core.Singleton;

   use namespace mx_internal;

   public class CursorManager extends Object
   {
      public function CursorManager() {
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public static const NO_CURSOR:int = 0;

      private static var implClassDependency:CursorManagerImpl;

      private static var _impl:ICursorManager;

      private static function get impl() : ICursorManager {
         if(!_impl)
         {
            _impl=ICursorManager(Singleton.getInstance("mx.managers::ICursorManager"));
         }
         return _impl;
      }

      public static function getInstance() : ICursorManager {
         return impl;
      }

      public static function get currentCursorID() : int {
         return impl.currentCursorID;
      }

      public static function set currentCursorID(param1:int) : void {
         impl.currentCursorID=param1;
         return;
      }

      public static function get currentCursorXOffset() : Number {
         return impl.currentCursorXOffset;
      }

      public static function set currentCursorXOffset(param1:Number) : void {
         impl.currentCursorXOffset=param1;
         return;
      }

      public static function get currentCursorYOffset() : Number {
         return impl.currentCursorYOffset;
      }

      public static function set currentCursorYOffset(param1:Number) : void {
         impl.currentCursorYOffset=param1;
         return;
      }

      public static function showCursor() : void {
         impl.showCursor();
         return;
      }

      public static function hideCursor() : void {
         impl.hideCursor();
         return;
      }

      public static function setCursor(param1:Class, param2:int=2, param3:Number=0, param4:Number=0) : int {
         return impl.setCursor(param1,param2,param3,param4);
      }

      public static function removeCursor(param1:int) : void {
         impl.removeCursor(param1);
         return;
      }

      public static function removeAllCursors() : void {
         impl.removeAllCursors();
         return;
      }

      public static function setBusyCursor() : void {
         impl.setBusyCursor();
         return;
      }

      public static function removeBusyCursor() : void {
         impl.removeBusyCursor();
         return;
      }

      mx_internal  static function registerToUseBusyCursor(param1:Object) : void {
         impl.registerToUseBusyCursor(param1);
         return;
      }

      mx_internal  static function unRegisterToUseBusyCursor(param1:Object) : void {
         impl.unRegisterToUseBusyCursor(param1);
         return;
      }
   }

}