package mx.controls
{
   import mx.core.IToggleButton;
   import mx.core.mx_internal;
   import flash.text.TextLineMetrics;
   import mx.core.FlexVersion;
   import flash.utils.getQualifiedClassName;
   import mx.core.UITextField;

   use namespace mx_internal;

   public class CheckBox extends Button implements IToggleButton
   {
      public function CheckBox() {
         super();
         _toggle=true;
         centerContent=false;
         extraSpacing=8;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      mx_internal  static var createAccessibilityImplementation:Function;

      override public function set emphasized(param1:Boolean) : void {
         return;
      }

      override public function set toggle(param1:Boolean) : void {
         return;
      }

      override protected function initializeAccessibility() : void {
         if(CheckBox.createAccessibilityImplementation != null)
         {
            CheckBox.createAccessibilityImplementation(this);
         }
         return;
      }

      override protected function measure() : void {
         var _loc1_:TextLineMetrics = null;
         var _loc2_:* = NaN;
         super.measure();
         if(!label && FlexVersion.compatibilityVersion >= FlexVersion.VERSION_4_0 && getQualifiedClassName(currentIcon).indexOf(".spark") >= 0)
         {
            _loc1_=measureText(label);
            _loc2_=_loc1_.height + UITextField.TEXT_HEIGHT_PADDING;
            _loc2_=_loc2_ + (getStyle("paddingTop") + getStyle("paddingBottom"));
            measuredMinHeight=measuredHeight=Math.max(_loc2_,measuredMinHeight);
         }
         return;
      }
   }

}