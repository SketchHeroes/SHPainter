package mx.containers
{
   import mx.core.mx_internal;

   use namespace mx_internal;

   public class TitleWindow extends Panel
   {
      public function TitleWindow() {
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      mx_internal  static var createAccessibilityImplementation:Function;

      public function get showCloseButton() : Boolean {
         return _showCloseButton;
      }

      public function set showCloseButton(param1:Boolean) : void {
         _showCloseButton=param1;
         return;
      }

      override protected function initializeAccessibility() : void {
         if(TitleWindow.createAccessibilityImplementation != null)
         {
            TitleWindow.createAccessibilityImplementation(this);
         }
         return;
      }
   }

}