package mx.controls
{
   import mx.controls.scrollClasses.ScrollBar;
   import mx.core.mx_internal;
   import flash.ui.Keyboard;
   import mx.controls.scrollClasses.ScrollBarDirection;

   use namespace mx_internal;

   public class VScrollBar extends ScrollBar
   {
      public function VScrollBar() {
         super();
         super.direction=ScrollBarDirection.VERTICAL;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      override public function set direction(param1:String) : void {
         return;
      }

      override public function get minWidth() : Number {
         return _minWidth;
      }

      override public function get minHeight() : Number {
         return _minHeight;
      }

      override protected function measure() : void {
         super.measure();
         measuredWidth=_minWidth;
         measuredHeight=_minHeight;
         return;
      }

      override mx_internal function isScrollBarKey(param1:uint) : Boolean {
         if(param1 == Keyboard.UP)
         {
            lineScroll(-1);
            return true;
         }
         if(param1 == Keyboard.DOWN)
         {
            lineScroll(1);
            return true;
         }
         if(param1 == Keyboard.PAGE_UP)
         {
            pageScroll(-1);
            return true;
         }
         if(param1 == Keyboard.PAGE_DOWN)
         {
            pageScroll(1);
            return true;
         }
         return super.isScrollBarKey(param1);
      }
   }

}