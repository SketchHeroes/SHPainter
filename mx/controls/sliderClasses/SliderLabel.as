package mx.controls.sliderClasses
{
   import mx.controls.Label;
   import mx.core.mx_internal;

   use namespace mx_internal;

   public class SliderLabel extends Label
   {
      public function SliderLabel() {
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      override mx_internal function getMinimumText(param1:String) : String {
         if(!param1 || param1.length < 1)
         {
            param1="W";
         }
         return param1;
      }
   }

}