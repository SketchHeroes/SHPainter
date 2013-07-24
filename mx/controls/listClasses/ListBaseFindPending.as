package mx.controls.listClasses
{
   import mx.core.mx_internal;
   import mx.collections.CursorBookmark;

   use namespace mx_internal;

   public class ListBaseFindPending extends Object
   {
      public function ListBaseFindPending(param1:String, param2:CursorBookmark, param3:CursorBookmark, param4:int, param5:int, param6:int) {
         super();
         this.searchString=param1;
         this.startingBookmark=param2;
         this.bookmark=param3;
         this.offset=param4;
         this.currentIndex=param5;
         this.stopIndex=param6;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public var bookmark:CursorBookmark;

      public var currentIndex:int;

      public var offset:int;

      public var searchString:String;

      public var startingBookmark:CursorBookmark;

      public var stopIndex:int;
   }

}