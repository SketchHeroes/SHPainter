package com.reinatech.shpainter.tools
{
   import com.reinatech.shpainter.filters.SmudgeMap;
   import flash.geom.Point;
   import flash.display.*;
   import com.reinatech.shpainter.DrawingSettings;


   public class SmudgeTool extends DrawingTool
   {
      public function SmudgeTool(param1:DrawingSettings) {
         this._redoBitmap=new Array();
         super();
         toolClassName="SmudgeTool";
         shortToolClassName="s";
         this.drawingSettings=param1;
         return;
      }

      private var _smudge:SmudgeMap;

      private var _isDrawn:Boolean = false;

      private var _redoBitmap:Array;

      override public function draw(param1:IBitmapDrawable, param2:Boolean=false, param3:Boolean=true) : void {
         var _loc4_:* = NaN;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:Point = null;
         var _loc10_:Point = null;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         if(param1  is  BitmapData)
         {
            targetDrawableContainer=param1 as BitmapData;
            if((param3) && !undoBitmap)
            {
               undoBitmap=targetDrawableContainer.clone();
            }
            if(!this._smudge)
            {
               this._smudge=new SmudgeMap(targetDrawableContainer.width,targetDrawableContainer.height);
               this._smudge.smooth=2;
               this._smudge.size=drawingSettings.getLineThickness();
               undoBitmap=targetDrawableContainer.clone();
            }
            if((param2) && !this._isDrawn)
            {
               if(drawPoints.length == 0)
               {
                  this.redo();
               }
               else
               {
                  _loc4_=0;
                  while(_loc4_ < drawPoints.length-1)
                  {
                     if(!drawPoints[_loc4_ + 1])
                     {
                        return;
                     }
                     _loc5_=drawPoints[_loc4_];
                     _loc6_=drawPoints[_loc4_ + 1];
                     _loc7_=_loc6_.x - _loc5_.x;
                     _loc8_=_loc6_.y - _loc5_.y;
                     this._drawSmudge(targetDrawableContainer,_loc6_.x,_loc6_.y,_loc7_,_loc8_);
                     _loc4_++;
                  }
               }
            }
            else
            {
               if(drawPoints[1])
               {
                  this._isDrawn=true;
                  _loc9_=drawPoints[drawPoints.length-1];
                  _loc10_=drawPoints[drawPoints.length - 2];
                  _loc11_=_loc9_.x - _loc10_.x;
                  _loc12_=_loc9_.y - _loc10_.y;
                  this._smudge.smudgeBitmap(targetDrawableContainer,_loc9_.x,_loc9_.y,_loc11_,_loc12_);
                  this._redoBitmap.push(targetDrawableContainer.clone());
               }
            }
            return;
         }
         throw new Error("Invalid target drawable container");
      }

      override public function drawFrame(param1:IBitmapDrawable, param2:int=0) : Point {
         this._isDrawn=false;
         targetDrawableContainer=param1 as BitmapData;
         this._drawTo(param2);
         return drawPoints[param2];
      }

      override public function redo() : void {
         var _loc1_:* = NaN;
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         if(this._redoBitmap.length == 0)
         {
            _loc1_=0;
            while(_loc1_ < drawPoints.length-1)
            {
               if(!drawPoints[_loc1_ + 1])
               {
                  return;
               }
               _loc2_=drawPoints[_loc1_];
               _loc3_=drawPoints[_loc1_ + 1];
               _loc4_=_loc3_.x - _loc2_.x;
               _loc5_=_loc3_.y - _loc2_.y;
               this._drawSmudge(targetDrawableContainer,_loc3_.x,_loc3_.y,_loc4_,_loc5_);
               _loc1_++;
            }
            return;
         }
         targetDrawableContainer.lock();
         undo();
         targetDrawableContainer.copyPixels(this._redoBitmap[this._redoBitmap.length-1],this._redoBitmap[this._redoBitmap.length-1].rect,new Point(0,0));
         targetDrawableContainer.unlock();
         return;
      }

      private function _drawTo(param1:int) : void {
         if(!drawPoints[param1 + 1])
         {
            return;
         }
         var _loc2_:Object = drawPoints[param1];
         var _loc3_:Object = drawPoints[param1 + 1];
         var _loc4_:int = _loc3_.x - _loc2_.x;
         var _loc5_:int = _loc3_.y - _loc2_.y;
         this._drawSmudge(targetDrawableContainer,_loc3_.x,_loc3_.y,_loc4_,_loc5_);
         return;
      }

      private function _drawSmudge(param1:BitmapData, param2:int, param3:int, param4:int, param5:int) : void {
         this._smudge.smudgeBitmap(param1,param2,param3,param4,param5);
         return;
      }

      override public function clone() : DrawingTool {
         var _loc1_:SmudgeTool = null;
         _loc1_=new SmudgeTool(drawingSettings);
         _loc1_._redoBitmap=this._redoBitmap;
         _loc1_.undoBitmap=undoBitmap;
         _loc1_._smudge=this._smudge;
         _loc1_.brushSprite=brushSprite;
         _loc1_.brushName=brushName;
         _loc1_.drawPoints=drawPoints;
         _loc1_.undoBitmap=undoBitmap;
         _loc1_.targetDrawableContainer=targetDrawableContainer;
         _loc1_.step=step;
         _loc1_.layerIndex=layerIndex;
         return _loc1_;
      }
   }

}