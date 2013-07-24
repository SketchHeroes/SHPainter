package mx.controls.listClasses
{
   import mx.core.mx_internal;

   use namespace mx_internal;

   public class ListRowInfo extends Object
   {
      public function ListRowInfo(param1:Number, param2:Number, param3:String, param4:Object=null) {
         super();
         this.y=param1;
         this.height=param2;
         this.uid=param3;
         this.data=param4;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public var data:Object;

      public var height:Number;

      public var itemOldY:Number;

      public var oldY:Number;

      public var uid:String;

      public var y:Number;
   }

}