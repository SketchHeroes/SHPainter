package mx.collections
{
   import mx.core.mx_internal;

   use namespace mx_internal;

   public class CursorBookmark extends Object
   {
      public function CursorBookmark(param1:Object) {
         super();
         this._value=param1;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      private static var _first:CursorBookmark;

      private static var _last:CursorBookmark;

      private static var _current:CursorBookmark;

      public static function get FIRST() : CursorBookmark {
         if(!_first)
         {
            _first=new CursorBookmark("${F}");
         }
         return _first;
      }

      public static function get LAST() : CursorBookmark {
         if(!_last)
         {
            _last=new CursorBookmark("${L}");
         }
         return _last;
      }

      public static function get CURRENT() : CursorBookmark {
         if(!_current)
         {
            _current=new CursorBookmark("${C}");
         }
         return _current;
      }

      private var _value:Object;

      public function get value() : Object {
         return this._value;
      }

      public function getViewIndex() : int {
         return -1;
      }
   }

}