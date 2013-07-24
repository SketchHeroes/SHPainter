package com.reinatech.shpainter.filters
{
   import flash.filters.DisplacementMapFilter;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.display.BitmapDataChannel;
   import flash.filters.DisplacementMapFilterMode;


   public class SmudgeMap extends Object
   {
      public function SmudgeMap(param1:int, param2:int) {
         super();
         this.createSpotMap();
         this._filterMap=new BitmapData(param1,param2,false,8421504);
         this._filter=new DisplacementMapFilter(this._filterMap,new Point(),BitmapDataChannel.RED,BitmapDataChannel.BLUE);
         this._filter.mode=DisplacementMapFilterMode.COLOR;
         return;
      }

      private var _filter:DisplacementMapFilter;

      private var _radius:int = 25;

      private var _spotMap:BitmapData;

      private var _filterMap:BitmapData;

      private var _spotX:int;

      private var _spotY:int;

      private var _smooth:int = 2;

      private function updateMap() : void {
         this._filterMap.fillRect(this._filterMap.rect,8421504);
         var _loc1_:Matrix = new Matrix();
         _loc1_.translate(this._spotX - this._radius,this._spotY - this._radius);
         this._filterMap.draw(this._spotMap,_loc1_);
         return;
      }

      private function createSpotMap() : void {
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = NaN;
         var _loc7_:* = 0;
         var _loc1_:int = this._radius * this._radius;
         var _loc2_:Number = 1 / this._smooth;
         this._spotMap=new BitmapData(2 * this._radius,2 * this._radius,false,8421504);
         var _loc3_:int = -this._radius;
         while(_loc3_ < this._radius)
         {
            _loc4_=-this._radius;
            while(_loc4_ < this._radius)
            {
               _loc5_=_loc3_ * _loc3_ + _loc4_ * _loc4_;
               if(_loc5_ < 16)
               {
                  _loc5_=16;
               }
               _loc6_=Math.pow(_loc5_ / _loc1_,_loc2_);
               if(_loc6_ < 1)
               {
                  _loc7_=128 * _loc6_;
                  this._spotMap.setPixel(_loc3_ + this._radius,_loc4_ + this._radius,_loc7_ << 16 | _loc7_);
               }
               _loc4_++;
            }
            _loc3_++;
         }
         return;
      }

      public function smudgeBitmap(param1:BitmapData, param2:int, param3:int, param4:int, param5:int) : void {
         this._spotX=param2;
         this._spotY=param3;
         this.updateMap();
         this._filter.scaleX=2 * param4;
         this._filter.scaleY=2 * param5;
         param1.applyFilter(param1,param1.rect,new Point(),this._filter);
         return;
      }

      public function get size() : int {
         return this._radius;
      }

      public function set size(param1:int) : void {
         this._radius=Math.round(param1 + 5);
         this.createSpotMap();
         return;
      }

      public function set smooth(param1:int) : void {
         if(param1 <= 0)
         {
            param1=0;
         }
         this._smooth=param1;
         this.createSpotMap();
         return;
      }

      public function get filter() : DisplacementMapFilter {
         return this._filter;
      }
   }

}