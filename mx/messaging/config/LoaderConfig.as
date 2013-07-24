package mx.messaging.config
{
   import mx.core.mx_internal;
   import flash.display.DisplayObject;
   import mx.utils.LoaderUtil;

   use namespace mx_internal;

   public class LoaderConfig extends Object
   {
      public function LoaderConfig() {
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public static function init(param1:DisplayObject) : void {
         if(!_url)
         {
            _url=LoaderUtil.normalizeURL(param1.loaderInfo);
            _parameters=param1.loaderInfo.parameters;
            _swfVersion=param1.loaderInfo.swfVersion;
         }
         return;
      }

      mx_internal  static var _parameters:Object;

      public static function get parameters() : Object {
         return _parameters;
      }

      mx_internal  static var _swfVersion:uint;

      public static function get swfVersion() : uint {
         return _swfVersion;
      }

      mx_internal  static var _url:String = null;

      public static function get url() : String {
         return _url;
      }
   }

}