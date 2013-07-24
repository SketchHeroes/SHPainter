package com.reinatech.shpainter.history
{
   import com.reinatech.shpainter.tools.*;
   import com.reinatech.shpainter.DrawingSettings;
   import flash.geom.Point;
   import com.reinatech.shpainter.Settings;


   public class HistoryStack extends Object
   {
      public function HistoryStack() {
         this._undoSteps=Settings.UNDO_STEPS;
         super();
         this._tools=new Array();
         this._index=0;
         return;
      }

      private static var _instance:HistoryStack;

      public static function getInstance() : HistoryStack {
         if(_instance == null)
         {
            _instance=new HistoryStack();
         }
         return _instance;
      }

      private var _tools:Array;

      private var _index:uint;

      private var _undoSteps:int;

      public function setIndex(param1:int) : void {
         this._index=param1;
         return;
      }

      public function putTool(param1:DrawingTool) : void {
         var _loc2_:* = this._index++;
         this._tools[_loc2_]=param1;
         this._tools.splice(this._index,this._tools.length - this._index);
         if(this._tools.length > this._undoSteps)
         {
            this._tools[this._tools.length - this._undoSteps-1].deleteUndo();
         }
         return;
      }

      public function previous() : DrawingTool {
         return this._tools[--this._index];
      }

      public function next() : DrawingTool {
         return this._tools[this._index++];
      }

      public function hasPreviousTool() : Boolean {
         return this._index > 0 && (this._tools[this._index-1].hasUndo());
      }

      public function hasNextTool() : Boolean {
         return this._index < this._tools.length;
      }

      public function getStack() : Array {
         return this._tools;
      }

      public function getToolsCount() : int {
         return this._tools.length;
      }

      public function getToolsToAnimate() : Array {
         var _loc1_:Array = new Array();
         var _loc2_:PenTool = new PenTool(new DrawingSettings());
         _loc2_.addDrawPoint(new Point(0,0));
         _loc1_.push(_loc2_);
         var _loc3_:* = 0;
         while(_loc3_ < this._index)
         {
            if(this._tools[_loc3_].getLayerIndex() == 0 || this._tools[_loc3_].getLayerIndex() == 1)
            {
               _loc1_.push(this._tools[_loc3_].clone());
            }
            _loc3_++;
         }
         return _loc1_;
      }

      public function getLastIndex() : int {
         return this._index;
      }

      public function clearHistory() : void {
         this._tools=new Array();
         this._index=0;
         return;
      }
   }

}