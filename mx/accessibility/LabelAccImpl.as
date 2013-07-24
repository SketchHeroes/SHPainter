package mx.accessibility
{
   import mx.core.mx_internal;
   import mx.controls.Label;
   import mx.core.UIComponent;
   import flash.events.Event;
   import flash.accessibility.Accessibility;

   use namespace mx_internal;

   public class LabelAccImpl extends AccImpl
   {
      public function LabelAccImpl(param1:UIComponent) {
         super(param1);
         role=AccConst.ROLE_SYSTEM_STATICTEXT;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public static function enableAccessibility() : void {
         Label.createAccessibilityImplementation=createAccessibilityImplementation;
         return;
      }

      mx_internal  static function createAccessibilityImplementation(param1:UIComponent) : void {
         param1.accessibilityImplementation=new LabelAccImpl(param1);
         return;
      }

      override protected function get eventsToHandle() : Array {
         return super.eventsToHandle.concat(["updateComplete"]);
      }

      override public function get_accState(param1:uint) : uint {
         var _loc2_:uint = getState(param1);
         _loc2_=_loc2_ & ~AccConst.STATE_SYSTEM_FOCUSABLE;
         _loc2_=_loc2_ | AccConst.STATE_SYSTEM_READONLY;
         return _loc2_;
      }

      override protected function getName(param1:uint) : String {
         var _loc2_:String = Label(master).text;
         return !(_loc2_ == null) && !(_loc2_ == "")?_loc2_:"";
      }

      override protected function eventHandler(param1:Event) : void {
         $eventHandler(param1);
         switch(param1.type)
         {
            case "updateComplete":
               Accessibility.sendEvent(master,0,AccConst.EVENT_OBJECT_NAMECHANGE);
               Accessibility.updateProperties();
               break;
         }
         return;
      }
   }

}