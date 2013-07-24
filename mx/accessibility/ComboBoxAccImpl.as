package mx.accessibility
{
   import mx.core.mx_internal;
   import mx.controls.ComboBox;
   import mx.core.UIComponent;
   import mx.collections.IViewCursor;
   import mx.collections.CursorBookmark;

   use namespace mx_internal;

   public class ComboBoxAccImpl extends ComboBaseAccImpl
   {
      public function ComboBoxAccImpl(param1:UIComponent) {
         super(param1);
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public static function enableAccessibility() : void {
         ComboBox.createAccessibilityImplementation=createAccessibilityImplementation;
         ListAccImpl.enableAccessibility();
         return;
      }

      mx_internal  static function createAccessibilityImplementation(param1:UIComponent) : void {
         param1.accessibilityImplementation=new ComboBoxAccImpl(param1);
         return;
      }

      override protected function getName(param1:uint) : String {
         if(param1 == 0)
         {
            return "";
         }
         var _loc2_:ComboBox = ComboBox(master);
         var _loc3_:IViewCursor = _loc2_.collectionIterator;
         _loc3_.seek(CursorBookmark.FIRST,param1-1);
         var _loc4_:Object = _loc3_.current;
         return _loc2_.itemToLabel(_loc4_);
      }
   }

}