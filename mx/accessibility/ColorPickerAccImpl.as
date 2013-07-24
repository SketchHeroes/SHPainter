package mx.accessibility
{
   import mx.core.mx_internal;
   import mx.controls.ColorPicker;
   import mx.core.UIComponent;
   import flash.events.Event;
   import mx.collections.IViewCursor;
   import mx.collections.CursorBookmark;
   import mx.controls.ComboBase;
   import flash.accessibility.Accessibility;
   import mx.events.DropdownEvent;

   use namespace mx_internal;

   public class ColorPickerAccImpl extends ComboBaseAccImpl
   {
      public function ColorPickerAccImpl(param1:UIComponent) {
         super(param1);
         param1.accessibilityProperties.description="Color Picker";
         Accessibility.updateProperties();
         ColorPicker(param1).addEventListener(DropdownEvent.OPEN,this.openHandler);
         ColorPicker(param1).addEventListener(DropdownEvent.CLOSE,this.closeHandler);
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public static function enableAccessibility() : void {
         ColorPicker.createAccessibilityImplementation=createAccessibilityImplementation;
         return;
      }

      mx_internal  static function createAccessibilityImplementation(param1:UIComponent) : void {
         param1.accessibilityImplementation=new ColorPickerAccImpl(param1);
         return;
      }

      private function openHandler(param1:Event) : void {
         ColorPicker(master).dropdown.addEventListener("change",this.dropdown_changeHandler);
         return;
      }

      private function closeHandler(param1:Event) : void {
         ColorPicker(master).dropdown.removeEventListener("change",this.dropdown_changeHandler);
         return;
      }

      private function dropdown_changeHandler(param1:Event) : void {
         master.dispatchEvent(new Event("childChange"));
         return;
      }

      override protected function getName(param1:uint) : String {
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(param1 == 0)
         {
            return "";
         }
         var _loc2_:ColorPicker = ColorPicker(master);
         var _loc3_:IViewCursor = _loc2_.collectionIterator;
         _loc3_.seek(CursorBookmark.FIRST,param1-1);
         var _loc4_:Object = _loc3_.current;
         if(typeof _loc4_ != "object")
         {
            _loc5_=_loc4_.toString(16);
            _loc6_=this.formatColorString(_loc5_);
            return _loc6_;
         }
         return !_loc4_.label?_loc4_.data:_loc4_.label;
      }

      override public function get_accState(param1:uint) : uint {
         var _loc2_:uint = getState(param1);
         if(param1 > 0)
         {
            _loc2_=_loc2_ | AccConst.STATE_SYSTEM_SELECTABLE;
            _loc2_=_loc2_ | AccConst.STATE_SYSTEM_SELECTED | AccConst.STATE_SYSTEM_FOCUSED;
         }
         return _loc2_;
      }

      override public function get_accValue(param1:uint) : String {
         if(ColorPicker(master).showingDropdown)
         {
            return ColorPicker(master).dropdown?ColorPicker(master).dropdown.textInput.text:null;
         }
         return ColorPicker(master).selectedColor.toString(16);
      }

      override public function getChildIDArray() : Array {
         var _loc1_:int = ColorPicker(master).dropdown?ColorPicker(master).dropdown.length:0;
         return createChildIDArray(_loc1_);
      }

      override protected function get eventsToHandle() : Array {
         return super.eventsToHandle.concat(["childChange"]);
      }

      override protected function eventHandler(param1:Event) : void {
         var _loc2_:* = 0;
         $eventHandler(param1);
         switch(param1.type)
         {
            case "childChange":
               _loc2_=ComboBase(master).selectedIndex;
               Accessibility.sendEvent(master,ColorPicker(master).dropdown.focusedIndex + 1,AccConst.EVENT_OBJECT_SELECTION);
               Accessibility.sendEvent(master,0,AccConst.EVENT_OBJECT_VALUECHANGE,true);
               break;
            case "valueCommit":
               Accessibility.sendEvent(master,0,AccConst.EVENT_OBJECT_VALUECHANGE);
               break;
         }
         return;
      }

      private function formatColorString(param1:String) : String {
         var _loc2_:* = "";
         var _loc3_:int = param1.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_=_loc2_ + (param1.charAt(_loc4_) + " ");
            _loc4_++;
         }
         return _loc2_;
      }
   }

}