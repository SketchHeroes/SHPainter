package mx.controls.listClasses
{
   import mx.core.mx_internal;
   import mx.collections.CursorBookmark;

   use namespace mx_internal;

   public class ListBaseSeekPending extends Object
   {
      public function ListBaseSeekPending(param1:CursorBookmark, param2:int) {
         super();
         this.bookmark=param1;
         this.offset=param2;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public var bookmark:CursorBookmark;

      public var offset:int;
   }

}