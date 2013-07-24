package mx.events
{
   import flash.events.MouseEvent;
   import mx.core.mx_internal;
   import mx.core.IUIComponent;
   import mx.core.DragSource;
   import flash.events.Event;

   use namespace mx_internal;

   public class DragEvent extends MouseEvent
   {
      public function DragEvent(param1:String, param2:Boolean=false, param3:Boolean=true, param4:IUIComponent=null, param5:DragSource=null, param6:String=null, param7:Boolean=false, param8:Boolean=false, param9:Boolean=false) {
         super(param1,param2,param3);
         this.dragInitiator=param4;
         this.dragSource=param5;
         this.action=param6;
         this.ctrlKey=param7;
         this.altKey=param8;
         this.shiftKey=param9;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public static const DRAG_COMPLETE:String = "dragComplete";

      public static const DRAG_DROP:String = "dragDrop";

      public static const DRAG_ENTER:String = "dragEnter";

      public static const DRAG_EXIT:String = "dragExit";

      public static const DRAG_OVER:String = "dragOver";

      public static const DRAG_START:String = "dragStart";

      public var action:String;

      public var draggedItem:Object;

      public var dragInitiator:IUIComponent;

      public var dragSource:DragSource;

      override public function clone() : Event {
         var _loc1_:DragEvent = new DragEvent(type,bubbles,cancelable,this.dragInitiator,this.dragSource,this.action,ctrlKey,altKey,shiftKey);
         _loc1_.relatedObject=this.relatedObject;
         _loc1_.localX=this.localX;
         _loc1_.localY=this.localY;
         return _loc1_;
      }
   }

}