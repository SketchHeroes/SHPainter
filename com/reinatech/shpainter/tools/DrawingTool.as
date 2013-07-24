package com.reinatech.shpainter.tools
{
   import com.reinatech.shpainter.DrawingSettings;
   import flash.geom.*;
   import com.reinatech.shpainter.tools.interfaces.*;
   import flash.display.*;
   import com.reinatech.shpainter.Brushes;


   public class DrawingTool extends Object implements IAnimateable, IUndoable, IRedoable, ISerializeable
   {
      public function DrawingTool() {
         this.drawPoints=new Array();
         super();
         return;
      }

      protected var brushSprite:Sprite;

      protected var brushName:String;

      protected var drawingSettings:DrawingSettings;

      protected var drawPoints:Array;

      protected var undoBitmap:BitmapData;

      protected var targetDrawableContainer:BitmapData;

      protected var toolClassName:String = "";

      protected var shortToolClassName:String = "";

      protected var step:int = 1;

      protected var layerIndex:int = 0;

      public function getToolName() : String {
         return this.toolClassName;
      }

      public function hasUndo() : Boolean {
         return this.undoBitmap == null?false:true;
      }

      public function deleteUndo() : void {
         if(this.undoBitmap != null)
         {
            this.undoBitmap.dispose();
            this.undoBitmap=null;
         }
         return;
      }

      public function getToolStep() : int {
         return this.step;
      }

      public function setLayerIdex(param1:int) : void {
         this.layerIndex=param1;
         return;
      }

      public function getLayerIndex() : int {
         return this.layerIndex;
      }

      public function setToolStep(param1:int) : void {
         this.step=param1;
         return;
      }

      public function addDrawPoint(param1:Point) : void {
         this.drawPoints.push(param1);
         return;
      }

      public function setDrawPoint(param1:Point, param2:int=0) : void {
         this.drawPoints[param2]=param1;
         return;
      }

      public function setLastPoint(param1:Point) : void {
         this.drawPoints[this.drawPoints.length-1]=param1;
         return;
      }

      public function getLastPoint() : Point {
         return this.drawPoints[this.drawPoints.length-1];
      }

      public function draw(param1:IBitmapDrawable, param2:Boolean=false, param3:Boolean=true) : void {
         return;
      }

      public function getTotalFrames() : int {
         return this.drawPoints.length-1;
      }

      public function drawFrame(param1:IBitmapDrawable, param2:int=0) : Point {
         return new Point();
      }

      public function setActiveCanvas(param1:BitmapData) : void {
         this.targetDrawableContainer=param1;
         return;
      }

      public function undo() : void {
         this.targetDrawableContainer.lock();
         this.targetDrawableContainer.copyPixels(this.undoBitmap,this.undoBitmap.rect,new Point(0,0));
         this.targetDrawableContainer.unlock();
         return;
      }

      public function redo() : void {
         return;
      }

      public function saveToolData() : String {
         var _loc1_:* = this.toolClassName + "&layer=" + this.layerIndex + "&brush=" + this.brushName + "&thickness=" + this.drawingSettings.getLineThickness() + "&color=" + this.drawingSettings.getForegroundColor() + "&alpha=" + this.drawingSettings.getOpacity() + "&points=";
         var _loc2_:* = 0;
         while(_loc2_ < this.drawPoints.length)
         {
            if(_loc2_ == this.drawPoints.length-1)
            {
               _loc1_=_loc1_ + (this.drawPoints[_loc2_].x + "_" + this.drawPoints[_loc2_].y);
            }
            else
            {
               _loc1_=_loc1_ + (this.drawPoints[_loc2_].x + "_" + this.drawPoints[_loc2_].y + "_");
            }
            _loc2_++;
         }
         if(this.drawingSettings.getBackgroundColor())
         {
            _loc1_=_loc1_ + ("&fill=" + this.drawingSettings.getBackgroundColor());
         }
         return _loc1_;
      }

      public function loadToolData(param1:String) : void {
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:* = 0;
         var _loc2_:Array = param1.split("&");
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_=_loc2_[_loc3_].toString().split("=");
            if(_loc4_[0])
            {
               switch(_loc4_[0])
               {
                  case "brush":
                     switch(_loc4_[1])
                     {
                        case "brush1":
                           this.brushSprite=Brushes.brush1;
                           break;
                        case "brush2":
                           this.brushSprite=Brushes.brush2;
                           break;
                        case "brush3":
                           this.brushSprite=Brushes.brush3;
                           break;
                        case "brush4":
                           this.brushSprite=Brushes.brush4;
                           break;
                        case "brush5":
                           this.brushSprite=Brushes.brush5;
                           break;
                        case "brush6":
                           this.brushSprite=Brushes.brush6;
                           break;
                        case "brush7":
                           this.brushSprite=Brushes.brush7;
                           break;
                        case "brush8":
                           this.brushSprite=Brushes.brush8;
                           break;
                        case "brush9":
                           this.brushSprite=Brushes.brush9;
                           break;
                        case "brush10":
                           this.brushSprite=Brushes.brush10;
                           break;
                        case "brush11":
                           this.brushSprite=Brushes.brush11;
                           break;
                        case "brush12":
                           this.brushSprite=Brushes.brush12;
                           break;
                        case "brush13":
                           this.brushSprite=Brushes.brush13;
                           break;
                        case "brush14":
                           this.brushSprite=Brushes.brush14;
                           break;
                        case "brush15":
                           this.brushSprite=Brushes.brush15;
                           break;
                        case "brush16":
                           this.brushSprite=Brushes.brush16;
                           break;
                        case "brush17":
                           this.brushSprite=Brushes.brush17;
                           break;
                        case "brush18":
                           this.brushSprite=Brushes.brush18;
                           break;
                        case "brush19":
                           this.brushSprite=Brushes.brush19;
                           break;
                        case "brush20":
                           this.brushSprite=Brushes.brush20;
                           break;
                        case "brush21":
                           this.brushSprite=Brushes.brush21;
                           break;
                        case "brush22":
                           this.brushSprite=Brushes.brush22;
                           break;
                        case "brush23":
                           this.brushSprite=Brushes.brush23;
                           break;
                        case "brush24":
                           this.brushSprite=Brushes.brush24;
                           break;
                        case "brush25":
                           this.brushSprite=Brushes.brush25;
                           break;
                        case "brush26":
                           this.brushSprite=Brushes.brush26;
                           break;
                        case "brush27":
                           this.brushSprite=Brushes.brush27;
                           break;
                        case "brush28":
                           this.brushSprite=Brushes.brush28;
                           break;
                        case "brush29":
                           this.brushSprite=Brushes.brush29;
                           break;
                        case "brush30":
                           this.brushSprite=Brushes.brush30;
                           break;
                        case "brush31":
                           this.brushSprite=Brushes.brush31;
                           break;
                        case "brush32":
                           this.brushSprite=Brushes.brush32;
                           break;
                        case "brush33":
                           this.brushSprite=Brushes.brush33;
                           break;
                        case "brush34":
                           this.brushSprite=Brushes.brush34;
                           break;
                        case "brush35":
                           this.brushSprite=Brushes.brush35;
                           break;
                        case "brush36":
                           this.brushSprite=Brushes.brush36;
                           break;
                        case "brush37":
                           this.brushSprite=Brushes.brush37;
                           break;
                        case "brush38":
                           this.brushSprite=Brushes.brush38;
                           break;
                        case "brush39":
                           this.brushSprite=Brushes.brush39;
                           break;
                        case "brush40":
                           this.brushSprite=Brushes.brush40;
                           break;
                        case "brush41":
                           this.brushSprite=Brushes.brush41;
                           break;
                        case "brush42":
                           this.brushSprite=Brushes.brush42;
                           break;
                        case "brush43":
                           this.brushSprite=Brushes.brush43;
                           break;
                        case "brush44":
                           this.brushSprite=Brushes.brush44;
                           break;
                        case "brush45":
                           this.brushSprite=Brushes.brush45;
                           break;
                        case "brush46":
                           this.brushSprite=Brushes.brush46;
                           break;
                        case "brush47":
                           this.brushSprite=Brushes.brush47;
                           break;
                        case "brush48":
                           this.brushSprite=Brushes.brush48;
                           break;
                        case "brush49":
                           this.brushSprite=Brushes.brush49;
                           break;
                        case "brush50":
                           this.brushSprite=Brushes.brush50;
                           break;
                     }
                     break;
                  case "thickness":
                     this.drawingSettings.setLineThickness(_loc4_[1]);
                     break;
                  case "color":
                     this.drawingSettings.setForegroundColor(_loc4_[1]);
                     break;
                  case "alpha":
                     this.drawingSettings.setOpacity(_loc4_[1]);
                     break;
                  case "points":
                     _loc5_=_loc4_[1].toString().split("_");
                     _loc6_=0;
                     while(_loc6_ < _loc5_.length)
                     {
                        this.drawPoints.push(new Point(_loc5_[_loc6_],_loc5_[_loc6_ + 1]));
                        _loc6_=_loc6_ + 2;
                     }
                     break;
                  case "fill":
                     this.drawingSettings.setBackgroundColor(_loc4_[1]);
                  case "layer":
                     this.layerIndex=_loc4_[1];
                     break;
               }
            }
            _loc3_++;
         }
         return;
      }

      public function clone() : DrawingTool {
         return null;
      }
   }

}