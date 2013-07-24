package mx.containers
{
   import mx.core.mx_internal;

   use namespace mx_internal;

   public class VBox extends Box
   {
      public function VBox() {
         super();
         layoutObject.direction=BoxDirection.VERTICAL;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      override public function set direction(param1:String) : void {
         return;
      }
   }

}