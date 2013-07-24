package com.reinatech.player
{
   import flash.utils.Timer;
   import flash.events.*;
   import com.reinatech.shpainter.tools.DrawingTool;
   import com.reinatech.shpainter.tools.BrushTool;
   import com.reinatech.player.events.PencilCursorPositionChangedEvent;
   import com.reinatech.player.events.AnimationFinishedEvent;
   import com.reinatech.player.events.ToolChangedEvent;
   import flash.geom.Point;
   import com.reinatech.shpainter.tools.SmudgeTool;


   public class Player extends EventDispatcher
   {
      public function Player() {
         super();
         this._animtimer=new Timer(10);
         this._steps=new Array();
         this._drawingTools=new Array();
         this._currDrawingToolIndex=0;
         this._lastDrawingToolIndex=0;
         return;
      }

      public static const CHANGE_STEP:String = "change.step";

      private var _steps:Array;

      private var _drawingTools:Array;

      private var _currDrawingToolIndex:int;

      private var _lastDrawingToolIndex:int;

      private var _currDrawingToolFrame:int;

      private var _playerCanvas:PlayerCanvas;

      private var _animtimer:Timer;

      public function play() : void {
         this._lastDrawingToolIndex=this._drawingTools.length-1;
         if(this._currDrawingToolIndex == this._lastDrawingToolIndex || this._currDrawingToolIndex > this._lastDrawingToolIndex)
         {
            this._currDrawingToolIndex=0;
            this._playerCanvas.clear();
         }
         this._currDrawingToolIndex++;
         this._play();
         dispatchEvent(new Event("change.step",true));
         return;
      }

      public function stop() : void {
         this._animtimer.removeEventListener(TimerEvent.TIMER,this._playNextFrame);
         this._animtimer.stop();
         var _loc1_:DrawingTool = this._drawingTools[this._currDrawingToolIndex];
         if(!(_loc1_  is  BrushTool) && !(this._currDrawingToolFrame == 0))
         {
            this._playerCanvas.setActiveBitmapData(_loc1_.getLayerIndex());
            _loc1_.draw(this._playerCanvas.getActiveBitmapData(),true,false);
            dispatchEvent(new PencilCursorPositionChangedEvent(PencilCursorPositionChangedEvent.CHANGE,true,false,_loc1_.getLastPoint()));
         }
         this._currDrawingToolFrame=0;
         this._playerCanvas.clearTempBitmapData();
         dispatchEvent(new AnimationFinishedEvent(AnimationFinishedEvent.CHANGE,true,false));
         return;
      }

      public function isPlaying() : Boolean {
         return this._animtimer.running;
      }

      public function drawTool(param1:int) : void {
         this._currDrawingToolIndex=param1;
         this._currDrawingToolFrame=0;
         this.undo(param1);
         dispatchEvent(new ToolChangedEvent(ToolChangedEvent.ActiveToolChanged,true,false,this._drawingTools[param1].getToolName(),this._currDrawingToolIndex));
         return;
      }

      public function playStep(param1:int) : void {
         dispatchEvent(new Event("change.step",true));
         if(this.isPlaying())
         {
            this.stop();
         }
         if(param1 == 0)
         {
            this._currDrawingToolIndex=this._steps[param1-1];
         }
         else
         {
            this._currDrawingToolIndex=this._steps[param1-1] + 1;
         }
         this._lastDrawingToolIndex=this._steps[param1];
         this.undo(this._currDrawingToolIndex-1);
         this._play();
         return;
      }

      public function drawNextStep() : void {
         dispatchEvent(new Event("change.step",true));
         var _loc1_:int = this._currDrawingToolIndex + 1;
         while(_loc1_ < this._drawingTools.length)
         {
            if(this._steps.indexOf(_loc1_) > 0)
            {
               this.drawTool(_loc1_);
               return;
            }
            _loc1_++;
         }
         this.drawTool(this._drawingTools.length-1);
         return;
      }

      public function drawPreviousStep() : void {
         var _loc1_:int = this._currDrawingToolIndex-1;
         while(_loc1_ > 0)
         {
            if(this._steps.indexOf(_loc1_) > 0)
            {
               this.drawTool(_loc1_);
               return;
            }
            _loc1_--;
         }
         this.drawTool(0);
         return;
      }

      public function setPlayerCanvas(param1:PlayerCanvas) : void {
         this._playerCanvas=param1;
         return;
      }

      public function getPlayerCanvas() : PlayerCanvas {
         return this._playerCanvas;
      }

      public function setSpeed(param1:int) : void {
         this._animtimer.delay=param1;
         return;
      }

      public function setSteps(param1:Array) : void {
         this._steps=param1.sort(Array.NUMERIC);
         return;
      }

      public function getSteps() : Array {
         return this._steps;
      }

      public function getStepByValue(param1:int) : int {
         var _loc2_:int = param1;
         while(_loc2_ < this._drawingTools.length)
         {
            if(this._steps.indexOf(_loc2_) > 0)
            {
               return this._steps.indexOf(_loc2_);
            }
            _loc2_++;
         }
         return -1;
      }

      public function isStepExist(param1:int) : Boolean {
         return this._steps.indexOf(param1) > 0;
      }

      public function getStepsCount() : int {
         return this._steps.length-1;
      }

      public function setDrawingTools(param1:Array) : void {
         this._drawingTools=param1;
         this._currDrawingToolIndex=this._drawingTools.length-1;
         return;
      }

      public function getDrawingTools() : Array {
         return this._drawingTools;
      }

      public function getDrawingTool(param1:int) : DrawingTool {
         return this._drawingTools[param1];
      }

      public function hasNextFrame() : Boolean {
         dispatchEvent(new Event("change.step",true));
         return !(this._currDrawingToolIndex == this._drawingTools.length-1);
      }

      private function _play() : void {
         if(this._animtimer.hasEventListener(TimerEvent.TIMER))
         {
            return;
         }
         this._animtimer.addEventListener(TimerEvent.TIMER,this._playNextFrame);
         this._animtimer.start();
         dispatchEvent(new Event("change.step",true));
         return;
      }

      private var _activeStep:int = 1;

      public function get currentStep() : int {
         return this.getStepByValue(this._currDrawingToolIndex);
      }

      private function _playNextFrame(param1:TimerEvent=null) : void {
         var _loc3_:Point = null;
         var _loc2_:DrawingTool = this._drawingTools[this._currDrawingToolIndex];
         if(this._activeStep != this.getStepByValue(this._currDrawingToolIndex))
         {
            dispatchEvent(new Event("change.step",true));
            this._activeStep=this.getStepByValue(this._currDrawingToolIndex);
         }
         if(!_loc2_)
         {
            this._currDrawingToolIndex--;
            this.stop();
            return;
         }
         var _loc4_:int = _loc2_.getLayerIndex();
         this._playerCanvas.setActiveBitmapData(_loc4_);
         dispatchEvent(new ToolChangedEvent(ToolChangedEvent.ActiveToolChanged,true,false,_loc2_.getToolName(),this._currDrawingToolIndex));
         if(this._currDrawingToolFrame == _loc2_.getTotalFrames())
         {
            this._playerCanvas.clearTempBitmapData();
            if(!(_loc2_  is  BrushTool || _loc2_  is  SmudgeTool))
            {
               _loc3_=_loc2_.drawFrame(this._playerCanvas.getActiveBitmapData(),_loc2_.getTotalFrames() + 1);
            }
            else
            {
               if(this._currDrawingToolFrame == 0)
               {
                  _loc3_=_loc2_.drawFrame(this._playerCanvas.getActiveBitmapData(),_loc2_.getTotalFrames());
               }
            }
            this._currDrawingToolFrame=0;
            if(this._currDrawingToolIndex == this._lastDrawingToolIndex)
            {
               this.stop();
               return;
            }
            this._currDrawingToolIndex++;
         }
         else
         {
            if(_loc2_  is  BrushTool || _loc2_  is  SmudgeTool)
            {
               this._playerCanvas.clearTempBitmapData();
               _loc3_=_loc2_.drawFrame(this._playerCanvas.getActiveBitmapData(),this._currDrawingToolFrame);
               if(_loc2_.getTotalFrames() - this._currDrawingToolFrame > 2)
               {
                  this._currDrawingToolFrame++;
                  _loc3_=_loc2_.drawFrame(this._playerCanvas.getActiveBitmapData(),this._currDrawingToolFrame);
                  this._currDrawingToolFrame++;
                  _loc3_=_loc2_.drawFrame(this._playerCanvas.getActiveBitmapData(),this._currDrawingToolFrame);
               }
            }
            else
            {
               this._playerCanvas.clearTempBitmapData();
               _loc3_=_loc2_.drawFrame(this._playerCanvas.getActiveTempBitmapData(),this._currDrawingToolFrame);
            }
            this._currDrawingToolFrame++;
         }
         if(_loc3_)
         {
            dispatchEvent(new PencilCursorPositionChangedEvent(PencilCursorPositionChangedEvent.CHANGE,true,false,_loc3_));
         }
         return;
      }

      public function initCanvas() : void {
         var _loc1_:DrawingTool = null;
         dispatchEvent(new Event("change.step",true));
         this._playerCanvas.getActiveBitmapData().lock();
         var _loc2_:* = 0;
         while(_loc2_ < this._drawingTools.length)
         {
            _loc1_=this._drawingTools[_loc2_] as DrawingTool;
            this._playerCanvas.setActiveBitmapData(_loc1_.getLayerIndex());
            _loc1_.draw(this._playerCanvas.getActiveBitmapData(),true,false);
            _loc2_++;
         }
         this._playerCanvas.getActiveBitmapData().unlock();
         this._currDrawingToolIndex=this._drawingTools.length-1;
         dispatchEvent(new ToolChangedEvent(ToolChangedEvent.ActiveToolChanged,true,false,_loc1_.getToolName(),this._currDrawingToolIndex));
         return;
      }

      private function undo(param1:int) : void {
         var _loc3_:* = 0;
         dispatchEvent(new Event("change.step",true));
         this._playerCanvas.clear();
         var _loc2_:* = 0;
         while(_loc2_ <= param1)
         {
            _loc3_=this._drawingTools[_loc2_].getLayerIndex();
            this._playerCanvas.setActiveBitmapData(_loc3_);
            this._drawingTools[param1].setActiveCanvas(this._playerCanvas.getActiveBitmapData());
            this._drawingTools[_loc2_].setActiveCanvas(this._playerCanvas.getActiveBitmapData());
            this._drawingTools[_loc2_].redo();
            _loc2_++;
         }
         return;
      }
   }

}