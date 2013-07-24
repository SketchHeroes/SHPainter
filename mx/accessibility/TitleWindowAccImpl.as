package mx.accessibility
{
   import mx.core.mx_internal;
   import mx.containers.TitleWindow;
   import mx.core.UIComponent;
   import flash.accessibility.Accessibility;
   import flash.events.Event;
   import mx.containers.Panel;
   import flash.events.MouseEvent;

   use namespace mx_internal;

   public class TitleWindowAccImpl extends PanelAccImpl
   {
      public function TitleWindowAccImpl(param1:UIComponent) {
         super(param1);
         Panel(param1).getTitleBar().addEventListener(MouseEvent.MOUSE_UP,this.eventHandler);
         Panel(param1).closeButton.addEventListener(MouseEvent.MOUSE_UP,this.eventHandler);
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public static function enableAccessibility() : void {
         TitleWindow.createAccessibilityImplementation=createAccessibilityImplementation;
         return;
      }

      mx_internal  static function createAccessibilityImplementation(param1:UIComponent) : void {
         var _loc2_:UIComponent = TitleWindow(param1).getTitleBar();
         _loc2_.accessibilityImplementation=new TitleWindowAccImpl(param1);
         Accessibility.sendEvent(_loc2_,0,AccConst.EVENT_OBJECT_CREATE);
         Accessibility.updateProperties();
         return;
      }

      override public function get_accState(param1:uint) : uint {
         var _loc2_:uint = getState(param1);
         _loc2_=_loc2_ | AccConst.STATE_SYSTEM_MOVEABLE;
         return _loc2_;
      }

      override protected function eventHandler(param1:Event) : void {
         $eventHandler(param1);
         switch(param1.type)
         {
            case MouseEvent.MOUSE_UP:
               if(param1.target == Panel(master).getTitleBar())
               {
                  Accessibility.sendEvent(Panel(master).getTitleBar(),0,AccConst.EVENT_OBJECT_LOCATIONCHANGE,true);
               }
               if(param1.target == Panel(master).closeButton)
               {
                  Accessibility.sendEvent(Panel(master).getTitleBar(),0,AccConst.EVENT_OBJECT_DESTROY,true);
               }
               Accessibility.updateProperties();
               break;
         }
         return;
      }
   }

}