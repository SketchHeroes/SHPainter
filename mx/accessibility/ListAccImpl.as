package mx.accessibility
{
   import mx.core.mx_internal;
   import mx.controls.List;
   import mx.core.UIComponent;

   use namespace mx_internal;

   public class ListAccImpl extends ListBaseAccImpl
   {
      public function ListAccImpl(param1:UIComponent) {
         super(param1);
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public static function enableAccessibility() : void {
         List.createAccessibilityImplementation=createAccessibilityImplementation;
         return;
      }

      mx_internal  static function createAccessibilityImplementation(param1:UIComponent) : void {
         param1.accessibilityImplementation=new ListAccImpl(param1);
         return;
      }
   }

}