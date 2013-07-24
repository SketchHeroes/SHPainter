package mx.accessibility
{
   import mx.core.mx_internal;
   import mx.controls.CheckBox;
   import mx.core.UIComponent;
   import mx.controls.Button;

   use namespace mx_internal;

   public class CheckBoxAccImpl extends ButtonAccImpl
   {
      public function CheckBoxAccImpl(param1:UIComponent) {
         super(param1);
         role=AccConst.ROLE_SYSTEM_CHECKBUTTON;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public static function enableAccessibility() : void {
         CheckBox.createAccessibilityImplementation=createAccessibilityImplementation;
         return;
      }

      mx_internal  static function createAccessibilityImplementation(param1:UIComponent) : void {
         param1.accessibilityImplementation=new CheckBoxAccImpl(param1);
         return;
      }

      override public function get_accState(param1:uint) : uint {
         var _loc2_:uint = getState(param1);
         if(Button(master).selected)
         {
            _loc2_=_loc2_ | AccConst.STATE_SYSTEM_CHECKED;
         }
         return _loc2_;
      }

      override public function get_accDefaultAction(param1:uint) : String {
         return Button(master).selected?"UnCheck":"Check";
      }
   }

}