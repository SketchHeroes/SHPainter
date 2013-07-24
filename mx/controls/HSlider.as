package mx.controls
{
   import mx.controls.sliderClasses.Slider;
   import mx.core.mx_internal;
   import mx.controls.sliderClasses.SliderDirection;

   use namespace mx_internal;

   public class HSlider extends Slider
   {
      public function HSlider() {
         super();
         direction=SliderDirection.HORIZONTAL;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";
   }

}