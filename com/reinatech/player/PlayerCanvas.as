package com.reinatech.player
{
   import mx.containers.Canvas;
   import flash.display.BitmapData;
   import flash.display.Bitmap;
   import com.reinatech.shpainter.tools.DrawingTool;
   import flash.display.Sprite;


   public class PlayerCanvas extends Object
   {
      public function PlayerCanvas(param1:Canvas) {
         super();
         this._targetPlayerCanvas=param1;
         this._bmdBackground=new BitmapData(this._targetPlayerCanvas.width,this._targetPlayerCanvas.height,true,0);
         this._bmBackground=new Bitmap(this._bmdBackground,"auto",true);
         this._bmdSketch=new BitmapData(this._targetPlayerCanvas.width,this._targetPlayerCanvas.height,true,0);
         this._bmSketch=new Bitmap(this._bmdSketch,"auto",true);
         this._bmd=new BitmapData(this._targetPlayerCanvas.width,this._targetPlayerCanvas.height,true,0);
         this._bm=new Bitmap(this._bmd,"auto",true);
         this._bmdTemp=new BitmapData(this._targetPlayerCanvas.width,this._targetPlayerCanvas.height,true,0);
         this._bmTemp=new Bitmap(this._bmdTemp,"auto",true);
         this._targetPlayerCanvas.rawChildren.addChild(this._bmSketch);
         this._targetPlayerCanvas.rawChildren.addChild(this._bmBackground);
         this._targetPlayerCanvas.rawChildren.addChild(this._bm);
         this._targetPlayerCanvas.rawChildren.addChild(this._bmTemp);
         this._activeBitmapData=this._bmd;
         return;
      }

      public static const DRAWING:int = 1;

      public static const BACKGROUND:int = 0;

      private var _targetPlayerCanvas:Canvas;

      private var _bmd:BitmapData;

      private var _bm:Bitmap;

      private var _bmdTemp:BitmapData;

      private var _bmTemp:Bitmap;

      private var _bmdBackground:BitmapData;

      private var _bmBackground:Bitmap;

      private var _bmdSketch:BitmapData;

      private var _bmSketch:Bitmap;

      private var _activeTool:DrawingTool;

      private var _activeBrush:Sprite;

      private var _currentLayerIndex:int = 0;

      private var _activeBitmapData:BitmapData;

      public function getActiveBitmapData() : BitmapData {
         return this._activeBitmapData;
      }

      public function getActiveTempBitmapData() : BitmapData {
         return this._bmdTemp;
      }

      public function setActiveBitmapData(param1:int=0) : void {
         if(PlayerCanvas.DRAWING == param1)
         {
            this._currentLayerIndex=1;
            this._activeBitmapData=this._bmd;
         }
         else
         {
            if(PlayerCanvas.BACKGROUND == param1)
            {
               this._currentLayerIndex=0;
               this._activeBitmapData=this._bmdBackground;
            }
            else
            {
               if(2 == param1)
               {
                  this._currentLayerIndex=2;
                  this._activeBitmapData=this._bmdSketch;
               }
            }
         }
         return;
      }

      public function clearTempBitmapData() : void {
         if(this._bmdTemp)
         {
            this._bmdTemp.dispose();
            this._bmdTemp=new BitmapData(this._targetPlayerCanvas.width,this._targetPlayerCanvas.height,true,0);
            this._bmTemp.bitmapData=this._bmdTemp;
         }
         return;
      }

      public function clear() : void {
         this.clearTempBitmapData();
         this._bmdBackground.dispose();
         this._bmdBackground=new BitmapData(this._targetPlayerCanvas.width,this._targetPlayerCanvas.height,true,0);
         this._bmBackground.bitmapData=this._bmdBackground;
         this._bmd.dispose();
         this._bmd=new BitmapData(this._targetPlayerCanvas.width,this._targetPlayerCanvas.height,true,0);
         this._bm.bitmapData=this._bmd;
         this._bmdSketch.dispose();
         this._bmdSketch=new BitmapData(this._targetPlayerCanvas.width,this._targetPlayerCanvas.height,true,0);
         this._bmSketch.bitmapData=this._bmdSketch;
         return;
      }
   }

}