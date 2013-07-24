package mx.accessibility
{
   import mx.core.mx_internal;
   import mx.controls.ComboBase;
   import mx.core.UIComponent;
   import flash.events.Event;
   import flash.accessibility.Accessibility;

   use namespace mx_internal;

   public class ComboBaseAccImpl extends AccImpl
   {
      public function ComboBaseAccImpl(param1:UIComponent) {
         super(param1);
         role=AccConst.ROLE_SYSTEM_COMBOBOX;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public static function enableAccessibility() : void {
         ComboBase.createAccessibilityImplementation=createAccessibilityImplementation;
         return;
      }

      mx_internal  static function createAccessibilityImplementation(param1:UIComponent) : void {
         param1.accessibilityImplementation=new ComboBaseAccImpl(param1);
         return;
      }

      override protected function get eventsToHandle() : Array {
         return super.eventsToHandle.concat(["change","valueCommit"]);
      }

      override public function get_accRole(param1:uint) : uint {
         return param1 == 0?role:AccConst.ROLE_SYSTEM_LISTITEM;
      }

      override public function get_accValue(param1:uint) : String {
         if(param1 == 0)
         {
            return ComboBase(master).text;
         }
         return null;
      }

      override public function get_accState(param1:uint) : uint {
         var _loc2_:uint = getState(param1);
         if(param1 > 0)
         {
            _loc2_=_loc2_ | AccConst.STATE_SYSTEM_SELECTABLE;
            if(ComboBase(master).selectedIndex == param1-1)
            {
               _loc2_=_loc2_ | AccConst.STATE_SYSTEM_SELECTED | AccConst.STATE_SYSTEM_FOCUSED;
            }
         }
         return _loc2_;
      }

      override public function getChildIDArray() : Array {
         var _loc1_:int = ComboBase(master).dataProvider?ComboBase(master).dataProvider.length:0;
         return createChildIDArray(_loc1_);
      }

      override protected function eventHandler(param1:Event) : void {
         var _loc2_:* = 0;
         var _loc3_:uint = 0;
         $eventHandler(param1);
         switch(param1.type)
         {
            case "change":
               _loc2_=ComboBase(master).selectedIndex;
               if(_loc2_ >= 0)
               {
                  _loc3_=_loc2_ + 1;
                  Accessibility.sendEvent(master,_loc3_,AccConst.EVENT_OBJECT_SELECTION);
                  Accessibility.sendEvent(master,0,AccConst.EVENT_OBJECT_VALUECHANGE);
               }
               break;
            case "valueCommit":
               Accessibility.sendEvent(master,0,AccConst.EVENT_OBJECT_VALUECHANGE);
               break;
         }
         return;
      }
   }

}