package mx.containers
{
   import mx.core.Container;
   import mx.containers.utilityClasses.IConstraintLayout;
   import mx.core.mx_internal;
   import mx.containers.utilityClasses.CanvasLayout;
   import mx.containers.utilityClasses.ConstraintColumn;
   import mx.containers.utilityClasses.ConstraintRow;

   use namespace mx_internal;

   public class Canvas extends Container implements IConstraintLayout
   {
      public function Canvas() {
         this.layoutObject=new CanvasLayout();
         this._constraintColumns=[];
         this._constraintRows=[];
         super();
         this.layoutObject.target=this;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      private var layoutObject:CanvasLayout;

      override mx_internal function get usePadding() : Boolean {
         return false;
      }

      private var _constraintColumns:Array;

      public function get constraintColumns() : Array {
         return this._constraintColumns;
      }

      public function set constraintColumns(param1:Array) : void {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(param1 != this._constraintColumns)
         {
            _loc2_=param1.length;
            _loc3_=0;
            while(_loc3_ < _loc2_)
            {
               ConstraintColumn(param1[_loc3_]).container=this;
               _loc3_++;
            }
            this._constraintColumns=param1;
            invalidateSize();
            invalidateDisplayList();
         }
         return;
      }

      private var _constraintRows:Array;

      public function get constraintRows() : Array {
         return this._constraintRows;
      }

      public function set constraintRows(param1:Array) : void {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(param1 != this._constraintRows)
         {
            _loc2_=param1.length;
            _loc3_=0;
            while(_loc3_ < _loc2_)
            {
               ConstraintRow(param1[_loc3_]).container=this;
               _loc3_++;
            }
            this._constraintRows=param1;
            invalidateSize();
            invalidateDisplayList();
         }
         return;
      }

      override protected function measure() : void {
         super.measure();
         this.layoutObject.measure();
         return;
      }

      override protected function updateDisplayList(param1:Number, param2:Number) : void {
         super.updateDisplayList(param1,param2);
         this.layoutObject.updateDisplayList(param1,param2);
         return;
      }
   }

}