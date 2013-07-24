package mx.geom
{
   import flash.geom.Rectangle;
   import mx.core.mx_internal;

   use namespace mx_internal;

   public class RoundedRectangle extends Rectangle
   {
      public function RoundedRectangle(param1:Number=0, param2:Number=0, param3:Number=0, param4:Number=0, param5:Number=0) {
         super(param1,param2,param3,param4);
         this.cornerRadius=param5;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public var cornerRadius:Number = 0;
   }

}