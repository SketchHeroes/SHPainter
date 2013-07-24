package com.reinatech.shpainter
{
   import com.reinatech.shpainter.components.RCanvas;
   import flash.display.BitmapData;
   import flash.display.Bitmap;
   import flash.utils.Timer;
   import com.reinatech.shpainter.tools.DrawingTool;
   import flash.display.Sprite;
   import flash.geom.Point;
   import com.reinatech.shpainter.history.HistoryStack;
   import flash.geom.Matrix;
   import flash.events.TimerEvent;
   import com.reinatech.shpainter.tools.LineTool;
   import flash.events.MouseEvent;
   import com.reinatech.shpainter.tools.BrushTool;
   import com.reinatech.shpainter.tools.AirBrushTool;
   import com.reinatech.shpainter.tools.PenTool;
   import com.reinatech.shpainter.tools.SmudgeTool;
   import com.reinatech.shpainter.tools.CurveTool;
   import com.reinatech.shpainter.tools.BucketTool;
   import com.reinatech.shpainter.tools.PolygonTool;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;


   public class SHPainterCanvas extends Object
   {
      public function SHPainterCanvas(param1:RCanvas) {
         this._drawTimer=new Timer(30);
         super();
         if(_instance)
         {
            throw new Error("SHPainterCanvas already initialized");
         }
         else
         {
            this._targetDrawingCanvas=param1;
            this._bmd=new BitmapData(this._targetDrawingCanvas.width,this._targetDrawingCanvas.height,true,0);
            this._bm=new Bitmap(this._bmd,"auto",true);
            this._bmdTemp=new BitmapData(this._targetDrawingCanvas.width,this._targetDrawingCanvas.height,true,0);
            this._bmTemp=new Bitmap(this._bmdTemp,"auto",true);
            this._bmdBackground=new BitmapData(this._targetDrawingCanvas.width,this._targetDrawingCanvas.height,true,0);
            this._bmBackground=new Bitmap(this._bmdBackground,"auto",true);
            this._bmdSketch=new BitmapData(this._targetDrawingCanvas.width,this._targetDrawingCanvas.height,true,0);
            this._bmSketch=new Bitmap(this._bmdSketch,"auto",true);
            this._emptyBitmap=new BitmapData(this._targetDrawingCanvas.width,this._targetDrawingCanvas.height,true,0);
            this._targetDrawingCanvas.rawChildren.addChild(this._bmSketch);
            this._targetDrawingCanvas.rawChildren.addChild(this._bmBackground);
            this._targetDrawingCanvas.rawChildren.addChild(this._bm);
            this._targetDrawingCanvas.rawChildren.addChild(this._bmTemp);
            _instance=this;
            return;
         }
      }

      public static const SKETCH:int = 2;

      public static const DRAWING:int = 1;

      public static const BACKGROUND:int = 0;

      private static var _instance:SHPainterCanvas;

      public static function getInstance() : SHPainterCanvas {
         if(!_instance)
         {
            throw new Error("SHPainterCanvas was not initialized");
         }
         else
         {
            return _instance;
         }
      }

      private var _targetDrawingCanvas:RCanvas;

      private var _bmd:BitmapData;

      private var _bmdTemp:BitmapData;

      private var _bm:Bitmap;

      private var _bmTemp:Bitmap;

      private var _bmdBackground:BitmapData;

      private var _bmBackground:Bitmap;

      private var _bmdSketch:BitmapData;

      private var _bmSketch:Bitmap;

      private var _emptyBitmap:BitmapData;

      private var _activeBitmapData:BitmapData;

      private var _drawTimer:Timer;

      private var _activeTool:DrawingTool;

      private var _activeBrush:Sprite;

      private var _isDragging:Boolean = false;

      private var _isCurving:Boolean = false;

      private var _isPolygonDrawing:Boolean = false;

      private var _pointForDoubleClickChecking:Point;

      private var _currentLayerIndex:int = 0;

      public function set activeTool(param1:DrawingTool) : void {
         this._activeTool=param1;
         this._setTargetCanvasListeners();
         return;
      }

      public function get activeTool() : DrawingTool {
         return this._activeTool;
      }

      public function set activeBrush(param1:int) : void {
         switch(param1)
         {
            case 0:
               Settings.CURRENT_BRUSH=Brushes.brush1;
               Settings.CURRENT_BRUSH_NAME="brush1";
               break;
            case 1:
               Settings.CURRENT_BRUSH=Brushes.brush2;
               Settings.CURRENT_BRUSH_NAME="brush2";
               break;
            case 2:
               Settings.CURRENT_BRUSH=Brushes.brush3;
               Settings.CURRENT_BRUSH_NAME="brush3";
               break;
            case 3:
               Settings.CURRENT_BRUSH=Brushes.brush4;
               Settings.CURRENT_BRUSH_NAME="brush4";
               break;
            case 4:
               Settings.CURRENT_BRUSH=Brushes.brush5;
               Settings.CURRENT_BRUSH_NAME="brush5";
               break;
            case 5:
               Settings.CURRENT_BRUSH=Brushes.brush6;
               Settings.CURRENT_BRUSH_NAME="brush6";
               break;
            case 6:
               Settings.CURRENT_BRUSH=Brushes.brush7;
               Settings.CURRENT_BRUSH_NAME="brush7";
               break;
            case 7:
               Settings.CURRENT_BRUSH=Brushes.brush8;
               Settings.CURRENT_BRUSH_NAME="brush8";
               break;
            case 8:
               Settings.CURRENT_BRUSH=Brushes.brush9;
               Settings.CURRENT_BRUSH_NAME="brush9";
               break;
            case 9:
               Settings.CURRENT_BRUSH=Brushes.brush10;
               Settings.CURRENT_BRUSH_NAME="brush10";
               break;
            case 10:
               Settings.CURRENT_BRUSH=Brushes.brush11;
               Settings.CURRENT_BRUSH_NAME="brush11";
               break;
            case 11:
               Settings.CURRENT_BRUSH=Brushes.brush12;
               Settings.CURRENT_BRUSH_NAME="brush12";
               break;
            case 12:
               Settings.CURRENT_BRUSH=Brushes.brush13;
               Settings.CURRENT_BRUSH_NAME="brush13";
               break;
            case 13:
               Settings.CURRENT_BRUSH=Brushes.brush14;
               Settings.CURRENT_BRUSH_NAME="brush14";
               break;
            case 14:
               Settings.CURRENT_BRUSH=Brushes.brush15;
               Settings.CURRENT_BRUSH_NAME="brush15";
               break;
            case 15:
               Settings.CURRENT_BRUSH=Brushes.brush16;
               Settings.CURRENT_BRUSH_NAME="brush16";
               break;
            case 16:
               Settings.CURRENT_BRUSH=Brushes.brush17;
               Settings.CURRENT_BRUSH_NAME="brush17";
               break;
            case 17:
               Settings.CURRENT_BRUSH=Brushes.brush18;
               Settings.CURRENT_BRUSH_NAME="brush18";
               break;
            case 18:
               Settings.CURRENT_BRUSH=Brushes.brush19;
               Settings.CURRENT_BRUSH_NAME="brush19";
               break;
            case 19:
               Settings.CURRENT_BRUSH=Brushes.brush20;
               Settings.CURRENT_BRUSH_NAME="brush20";
               break;
            case 20:
               Settings.CURRENT_BRUSH=Brushes.brush21;
               Settings.CURRENT_BRUSH_NAME="brush21";
               break;
            case 21:
               Settings.CURRENT_BRUSH=Brushes.brush22;
               Settings.CURRENT_BRUSH_NAME="brush22";
               break;
            case 22:
               Settings.CURRENT_BRUSH=Brushes.brush23;
               Settings.CURRENT_BRUSH_NAME="brush23";
               break;
            case 23:
               Settings.CURRENT_BRUSH=Brushes.brush24;
               Settings.CURRENT_BRUSH_NAME="brush24";
               break;
            case 24:
               Settings.CURRENT_BRUSH=Brushes.brush25;
               Settings.CURRENT_BRUSH_NAME="brush25";
               break;
            case 25:
               Settings.CURRENT_BRUSH=Brushes.brush26;
               Settings.CURRENT_BRUSH_NAME="brush26";
               break;
            case 26:
               Settings.CURRENT_BRUSH=Brushes.brush27;
               Settings.CURRENT_BRUSH_NAME="brush27";
               break;
            case 27:
               Settings.CURRENT_BRUSH=Brushes.brush28;
               Settings.CURRENT_BRUSH_NAME="brush28";
               break;
            case 28:
               Settings.CURRENT_BRUSH=Brushes.brush29;
               Settings.CURRENT_BRUSH_NAME="brush29";
               break;
            case 29:
               Settings.CURRENT_BRUSH=Brushes.brush30;
               Settings.CURRENT_BRUSH_NAME="brush30";
               break;
            case 30:
               Settings.CURRENT_BRUSH=Brushes.brush31;
               Settings.CURRENT_BRUSH_NAME="brush31";
               break;
            case 31:
               Settings.CURRENT_BRUSH=Brushes.brush32;
               Settings.CURRENT_BRUSH_NAME="brush32";
               break;
            case 32:
               Settings.CURRENT_BRUSH=Brushes.brush33;
               Settings.CURRENT_BRUSH_NAME="brush33";
               break;
            case 33:
               Settings.CURRENT_BRUSH=Brushes.brush34;
               Settings.CURRENT_BRUSH_NAME="brush34";
               break;
            case 34:
               Settings.CURRENT_BRUSH=Brushes.brush35;
               Settings.CURRENT_BRUSH_NAME="brush35";
               break;
            case 35:
               Settings.CURRENT_BRUSH=Brushes.brush36;
               Settings.CURRENT_BRUSH_NAME="brush36";
               break;
            case 36:
               Settings.CURRENT_BRUSH=Brushes.brush37;
               Settings.CURRENT_BRUSH_NAME="brush37";
               break;
            case 37:
               Settings.CURRENT_BRUSH=Brushes.brush38;
               Settings.CURRENT_BRUSH_NAME="brush38";
               break;
            case 38:
               Settings.CURRENT_BRUSH=Brushes.brush39;
               Settings.CURRENT_BRUSH_NAME="brush39";
               break;
            case 39:
               Settings.CURRENT_BRUSH=Brushes.brush40;
               Settings.CURRENT_BRUSH_NAME="brush40";
               break;
            case 40:
               Settings.CURRENT_BRUSH=Brushes.brush41;
               Settings.CURRENT_BRUSH_NAME="brush41";
               break;
            case 41:
               Settings.CURRENT_BRUSH=Brushes.brush42;
               Settings.CURRENT_BRUSH_NAME="brush42";
               break;
            case 42:
               Settings.CURRENT_BRUSH=Brushes.brush43;
               Settings.CURRENT_BRUSH_NAME="brush43";
               break;
            case 43:
               Settings.CURRENT_BRUSH=Brushes.brush44;
               Settings.CURRENT_BRUSH_NAME="brush44";
               break;
            case 44:
               Settings.CURRENT_BRUSH=Brushes.brush45;
               Settings.CURRENT_BRUSH_NAME="brush45";
               break;
            case 45:
               Settings.CURRENT_BRUSH=Brushes.brush46;
               Settings.CURRENT_BRUSH_NAME="brush46";
               break;
            case 46:
               Settings.CURRENT_BRUSH=Brushes.brush47;
               Settings.CURRENT_BRUSH_NAME="brush47";
               break;
            case 47:
               Settings.CURRENT_BRUSH=Brushes.brush48;
               Settings.CURRENT_BRUSH_NAME="brush48";
               break;
            case 48:
               Settings.CURRENT_BRUSH=Brushes.brush49;
               Settings.CURRENT_BRUSH_NAME="brush49";
               break;
            case 49:
               Settings.CURRENT_BRUSH=Brushes.brush50;
               Settings.CURRENT_BRUSH_NAME="brush50";
               break;
         }
         return;
      }

      public function getPixelColor(param1:Point) : uint {
         return this._activeBitmapData.getPixel32(param1.x,param1.y);
      }

      public function undoState() : void {
         var _loc2_:DrawingTool = null;
         var _loc1_:HistoryStack = HistoryStack.getInstance();
         if(_loc1_.hasPreviousTool())
         {
            _loc2_=_loc1_.previous();
            _loc2_.undo();
         }
         return;
      }

      public function redoState() : void {
         var _loc2_:DrawingTool = null;
         var _loc1_:HistoryStack = HistoryStack.getInstance();
         if(_loc1_.hasNextTool())
         {
            _loc2_=_loc1_.next();
            _loc2_.redo();
         }
         return;
      }

      public function setActiveBitmapData(param1:int=0) : void {
         if(SHPainterCanvas.DRAWING == param1)
         {
            this._currentLayerIndex=1;
            this._activeBitmapData=this._bmd;
         }
         else
         {
            if(SHPainterCanvas.BACKGROUND == param1)
            {
               this._currentLayerIndex=0;
               this._activeBitmapData=this._bmdBackground;
            }
            else
            {
               if(SHPainterCanvas.SKETCH == param1)
               {
                  this._currentLayerIndex=2;
                  this._activeBitmapData=this._bmdSketch;
               }
            }
         }
         return;
      }

      public function getActiveBitmapData() : BitmapData {
         return this._activeBitmapData;
      }

      public function loadSketch(param1:Bitmap) : void {
         var _loc2_:Number = this._targetDrawingCanvas.width / param1.width;
         var _loc3_:Number = this._targetDrawingCanvas.height / param1.height;
         var _loc4_:Matrix = new Matrix();
         _loc4_.scale(_loc2_,_loc3_);
         this._bmdSketch.draw(param1,_loc4_);
         return;
      }

      public function setLayerVisibility(param1:int, param2:Boolean) : void {
         switch(param1)
         {
            case 0:
               if(this._bmSketch)
               {
                  this._bmSketch.alpha=param2?1:0;
               }
               break;
            case 1:
               this._bmBackground.alpha=param2?1:0;
               break;
            case 2:
               this._bm.alpha=param2?1:0;
               break;
         }
         return;
      }

      private function _setTargetCanvasListeners() : void {
         this._targetDrawingCanvas.clearEvents();
         this._drawTimer.removeEventListener(TimerEvent.TIMER,this._onPenMouseMove);
         if(this._activeTool  is  LineTool)
         {
            this._targetDrawingCanvas.addEventListener(MouseEvent.MOUSE_DOWN,this._onLineMouseDown);
            this._targetDrawingCanvas.addEventListener(MouseEvent.MOUSE_MOVE,this._onLineMouseMove);
            this._targetDrawingCanvas.addEventListener(MouseEvent.MOUSE_UP,this._onLineMouseUp);
         }
         else
         {
            if(this._activeTool  is  BrushTool || this._activeTool  is  AirBrushTool || this._activeTool  is  PenTool || this._activeTool  is  SmudgeTool)
            {
               this._targetDrawingCanvas.addEventListener(MouseEvent.MOUSE_DOWN,this._onBrushMouseDown);
               if(this._activeTool  is  PenTool)
               {
                  this._drawTimer.addEventListener(TimerEvent.TIMER,this._onPenMouseMove);
                  this._drawTimer.start();
               }
               else
               {
                  this._targetDrawingCanvas.addEventListener(MouseEvent.MOUSE_MOVE,this._onBrushMouseMove);
               }
               this._targetDrawingCanvas.addEventListener(MouseEvent.MOUSE_UP,this._onBrushMouseUp);
               this._targetDrawingCanvas.addEventListener(MouseEvent.MOUSE_OUT,this._onBrushMouseUp);
            }
            else
            {
               if(this._activeTool  is  CurveTool)
               {
                  this._targetDrawingCanvas.addEventListener(MouseEvent.MOUSE_DOWN,this._onCurveMouseDown);
                  this._targetDrawingCanvas.addEventListener(MouseEvent.MOUSE_MOVE,this._onCurveMouseMove);
                  this._targetDrawingCanvas.addEventListener(MouseEvent.MOUSE_UP,this._onCurveMouseUp);
               }
               else
               {
                  if(this._activeTool  is  BucketTool)
                  {
                     this._targetDrawingCanvas.addEventListener(MouseEvent.MOUSE_DOWN,this._onBucketMouseDown);
                  }
                  else
                  {
                     if(this._activeTool  is  PolygonTool)
                     {
                        this._targetDrawingCanvas.addEventListener(MouseEvent.MOUSE_DOWN,this._onPolygonMouseDown);
                        this._targetDrawingCanvas.addEventListener(MouseEvent.MOUSE_MOVE,this._onPolygonMouseMove);
                     }
                  }
               }
            }
         }
         return;
      }

      private function _onLineMouseDown(param1:MouseEvent) : void {
         this._createNewActiveToolInstance();
         this._activeTool.addDrawPoint(new Point(param1.localX,param1.localY));
         this._isDragging=true;
         return;
      }

      private function _onLineMouseMove(param1:MouseEvent) : void {
         if(this._isDragging)
         {
            this._clearTempBitmapData();
            this._activeTool.draw(this._bmdTemp);
            this._activeTool.addDrawPoint(new Point(param1.localX,param1.localY));
         }
         return;
      }

      private function _onLineMouseUp(param1:MouseEvent) : void {
         if(this._isDragging)
         {
            this._activeTool.draw(this.getActiveBitmapData(),true);
            this._isDragging=false;
            this._clearTempBitmapData();
            this._addActiveToolToHistory();
         }
         return;
      }

      private function _onBrushMouseDown(param1:MouseEvent) : void {
         this._createNewActiveToolInstance();
         this._activeTool.addDrawPoint(new Point(param1.localX,param1.localY));
         this._activeTool.draw(this.getActiveBitmapData());
         this._isDragging=true;
         return;
      }

      private function _onBrushMouseMove(param1:MouseEvent) : void {
         if(this._isDragging)
         {
            if(this._activeTool  is  AirBrushTool)
            {
               this._clearTempBitmapData();
               this._activeTool.addDrawPoint(new Point(param1.localX,param1.localY));
               this._activeTool.draw(this._bmdTemp);
            }
            else
            {
               this._activeTool.addDrawPoint(new Point(param1.localX,param1.localY));
               this._activeTool.draw(this.getActiveBitmapData());
            }
         }
         return;
      }

      private function _onBrushMouseUp(param1:MouseEvent) : void {
         if(this._isDragging)
         {
            if(this._activeTool  is  PenTool || this._activeTool  is  AirBrushTool)
            {
               this._clearTempBitmapData();
               this._activeTool.addDrawPoint(new Point(param1.localX,param1.localY));
               this._activeTool.draw(this.getActiveBitmapData(),true);
            }
            this._isDragging=false;
            this._addActiveToolToHistory();
         }
         return;
      }

      private function _onPenMouseMove(param1:TimerEvent) : void {
         if(this._isDragging)
         {
            this._clearTempBitmapData();
            this._activeTool.addDrawPoint(new Point(this._targetDrawingCanvas.mouseX,this._targetDrawingCanvas.mouseY));
            this._activeTool.draw(this._bmdTemp);
         }
         return;
      }

      private function _onCurveMouseDown(param1:MouseEvent) : void {
         if(!this._isCurving)
         {
            this._createNewActiveToolInstance();
            this._activeTool.setDrawPoint(new Point(param1.localX,param1.localY),0);
            this._isDragging=true;
         }
         return;
      }

      private function _onCurveMouseMove(param1:MouseEvent) : void {
         if(this._isDragging)
         {
            this._clearTempBitmapData();
            if(this._isCurving)
            {
               this._activeTool.addDrawPoint(new Point(param1.localX,param1.localY));
            }
            else
            {
               this._activeTool.setDrawPoint(new Point(param1.localX,param1.localY),1);
            }
            this._activeTool.draw(this._bmdTemp);
         }
         return;
      }

      private function _onCurveMouseUp(param1:MouseEvent) : void {
         this._isCurving=!this._isCurving;
         if((this._isDragging) && !this._isCurving)
         {
            this._activeTool.draw(this.getActiveBitmapData(),true);
            this._isDragging=false;
            this._clearTempBitmapData();
            this._addActiveToolToHistory();
         }
         return;
      }

      private function _onPolygonMouseDown(param1:MouseEvent) : void {
         var _loc2_:Point = null;
         if(!this._isPolygonDrawing)
         {
            this._createNewActiveToolInstance();
            this._pointForDoubleClickChecking=new Point(param1.localX,param1.localY);
            this._activeTool.addDrawPoint(new Point(param1.localX,param1.localY));
            this._activeTool.addDrawPoint(new Point(param1.localX,param1.localY));
            this._isPolygonDrawing=true;
         }
         else
         {
            _loc2_=new Point(param1.localX,param1.localY);
            if(_loc2_.x == this._pointForDoubleClickChecking.x && _loc2_.y == this._pointForDoubleClickChecking.y)
            {
               this._isPolygonDrawing=false;
               this._activeTool.draw(this.getActiveBitmapData(),true);
               this._clearTempBitmapData();
               this._addActiveToolToHistory();
            }
            else
            {
               this._pointForDoubleClickChecking=_loc2_;
               this._activeTool.addDrawPoint(_loc2_);
            }
         }
         return;
      }

      private function _onPolygonMouseMove(param1:MouseEvent) : void {
         if(this._isPolygonDrawing)
         {
            this._clearTempBitmapData();
            this._activeTool.setLastPoint(new Point(param1.localX,param1.localY));
            this._activeTool.draw(this._bmdTemp);
         }
         return;
      }

      private function _onBucketMouseDown(param1:MouseEvent) : void {
         this._createNewActiveToolInstance();
         this._activeTool.setDrawPoint(new Point(param1.localX,param1.localY),0);
         this._activeTool.draw(this.getActiveBitmapData());
         this._addActiveToolToHistory();
         return;
      }

      private function _createNewActiveToolInstance() : void {
         var _loc1_:Class = getDefinitionByName(getQualifiedClassName(this._activeTool)) as Class;
         this._activeTool=new _loc1_(Settings.getInstance().getDrawingSettings().clone());
         this._activeTool.setLayerIdex(this._currentLayerIndex);
         return;
      }

      private function _addActiveToolToHistory() : void {
         HistoryStack.getInstance().putTool(this._activeTool);
         return;
      }

      private function _clearTempBitmapData() : void {
         if(this._bmdTemp)
         {
            this._bmdTemp.copyPixels(this._emptyBitmap,this._emptyBitmap.rect,new Point(0,0));
         }
         return;
      }

      public function clear() : void {
         this._bmdBackground.copyPixels(this._emptyBitmap,this._emptyBitmap.rect,new Point(0,0));
         this._bmd.copyPixels(this._emptyBitmap,this._emptyBitmap.rect,new Point(0,0));
         this._bmdTemp.copyPixels(this._emptyBitmap,this._emptyBitmap.rect,new Point(0,0));
         this._bmdSketch.copyPixels(this._emptyBitmap,this._emptyBitmap.rect,new Point(0,0));
         HistoryStack.getInstance().clearHistory();
         return;
      }

      public function lock() : void {
         this._targetDrawingCanvas.clearEvents();
         return;
      }

      public function unlock() : void {
         this._setTargetCanvasListeners();
         return;
      }

      public function lockBitmaps() : void {
         this._bmdBackground.lock();
         this._bmd.lock();
         this._bmdTemp.lock();
         this._bmdSketch.lock();
         return;
      }

      public function unlockBitmaps() : void {
         this._bmdBackground.unlock();
         this._bmd.unlock();
         this._bmdTemp.unlock();
         this._bmdSketch.unlock();
         return;
      }
   }

}