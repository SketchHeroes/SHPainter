package mx.containers
{
   import mx.core.mx_internal;
   import mx.core.ScrollPolicy;
   import mx.core.Container;

   use namespace mx_internal;

   public class ControlBar extends Box
   {
      public function ControlBar() {
         super();
         direction=BoxDirection.HORIZONTAL;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      override public function set enabled(param1:Boolean) : void {
         if(param1 != super.enabled)
         {
            super.enabled=param1;
            alpha=param1?1:0.4;
         }
         return;
      }

      override public function get horizontalScrollPolicy() : String {
         return ScrollPolicy.OFF;
      }

      override public function set horizontalScrollPolicy(param1:String) : void {
         return;
      }

      override public function set includeInLayout(param1:Boolean) : void {
         var _loc2_:Container = null;
         if(includeInLayout != param1)
         {
            super.includeInLayout=param1;
            _loc2_=parent as Container;
            if(_loc2_)
            {
               _loc2_.invalidateViewMetricsAndPadding();
            }
         }
         return;
      }

      override public function get verticalScrollPolicy() : String {
         return ScrollPolicy.OFF;
      }

      override public function set verticalScrollPolicy(param1:String) : void {
         return;
      }

      override public function invalidateSize() : void {
         super.invalidateSize();
         if((parent) && parent  is  Container)
         {
            Container(parent).invalidateViewMetricsAndPadding();
         }
         return;
      }

      override protected function updateDisplayList(param1:Number, param2:Number) : void {
         super.updateDisplayList(param1,param2);
         if(contentPane)
         {
            contentPane.opaqueBackground=null;
         }
         return;
      }
   }

}