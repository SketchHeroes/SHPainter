package mx.preloaders
{
   import flash.display.Sprite;
   import mx.core.mx_internal;
   import flash.geom.Rectangle;
   import mx.geom.RoundedRectangle;
   import flash.text.TextField;
   import flash.events.ProgressEvent;
   import flash.events.Event;
   import mx.events.RSLEvent;
   import mx.events.FlexEvent;
   import flash.text.TextFormat;
   import flash.utils.getTimer;
   import flash.display.Graphics;
   import flash.geom.Matrix;
   import flash.display.GradientType;
   import mx.graphics.RectangularDropShadow;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.system.LoaderContext;
   import flash.utils.getDefinitionByName;
   import flash.events.IOErrorEvent;
   import flash.system.ApplicationDomain;
   import flash.net.URLRequest;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import flash.display.LoaderInfo;

   use namespace mx_internal;

   public class DownloadProgressBar extends Sprite implements IPreloaderDisplay
   {
      public function DownloadProgressBar() {
         this._labelRect=this.labelRect;
         this._percentRect=this.percentRect;
         this._borderRect=this.borderRect;
         this._barFrameRect=this.barFrameRect;
         this._barRect=this.barRect;
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      private static var _initializingLabel:String = "Initializing";

      public static function get initializingLabel() : String {
         return _initializingLabel;
      }

      public static function set initializingLabel(param1:String) : void {
         _initializingLabel=param1;
         return;
      }

      protected var MINIMUM_DISPLAY_TIME:uint = 0;

      protected var DOWNLOAD_PERCENTAGE:uint = 60;

      private var _showProgressBar:Boolean = true;

      private var _labelRect:Rectangle;

      private var _percentRect:Rectangle;

      private var _borderRect:RoundedRectangle;

      private var _barFrameRect:RoundedRectangle;

      private var _barRect:RoundedRectangle;

      private var _xOffset:Number = 20;

      private var _yOffset:Number = 20;

      private var _maximum:Number = 0;

      private var _value:Number = 0;

      private var _barSprite:Sprite;

      private var _barFrameSprite:Sprite;

      private var _labelObj:TextField;

      private var _percentObj:TextField;

      private var _startTime:int;

      private var _displayTime:int;

      private var _startedLoading:Boolean = false;

      private var _startedInit:Boolean = false;

      private var _showingDisplay:Boolean = false;

      private var _displayStartCount:uint = 0;

      private var _initProgressCount:uint = 0;

      protected var initProgressTotal:uint = 6;

      private var _visible:Boolean = false;

      override public function get visible() : Boolean {
         return this._visible;
      }

      override public function set visible(param1:Boolean) : void {
         if(!this._visible && (param1))
         {
            this.show();
         }
         else
         {
            if((this._visible) && !param1)
            {
               this.hide();
            }
         }
         this._visible=param1;
         return;
      }

      private var _backgroundAlpha:Number = 1;

      public function get backgroundAlpha() : Number {
         if(!isNaN(this._backgroundAlpha))
         {
            return this._backgroundAlpha;
         }
         return 1;
      }

      public function set backgroundAlpha(param1:Number) : void {
         this._backgroundAlpha=param1;
         return;
      }

      private var _backgroundColor:uint;

      public function get backgroundColor() : uint {
         return this._backgroundColor;
      }

      public function set backgroundColor(param1:uint) : void {
         this._backgroundColor=param1;
         return;
      }

      private var _backgroundImage:Object;

      public function get backgroundImage() : Object {
         return this._backgroundImage;
      }

      public function set backgroundImage(param1:Object) : void {
         this._backgroundImage=param1;
         return;
      }

      private var _backgroundSize:String = "";

      public function get backgroundSize() : String {
         return this._backgroundSize;
      }

      public function set backgroundSize(param1:String) : void {
         this._backgroundSize=param1;
         return;
      }

      private var _preloader:Sprite;

      public function set preloader(param1:Sprite) : void {
         this._preloader=param1;
         param1.addEventListener(ProgressEvent.PROGRESS,this.progressHandler);
         param1.addEventListener(Event.COMPLETE,this.completeHandler);
         param1.addEventListener(RSLEvent.RSL_PROGRESS,this.rslProgressHandler);
         param1.addEventListener(RSLEvent.RSL_COMPLETE,this.rslCompleteHandler);
         param1.addEventListener(RSLEvent.RSL_ERROR,this.rslErrorHandler);
         param1.addEventListener(FlexEvent.INIT_PROGRESS,this.initProgressHandler);
         param1.addEventListener(FlexEvent.INIT_COMPLETE,this.initCompleteHandler);
         return;
      }

      private var _stageHeight:Number = 375;

      public function get stageHeight() : Number {
         return this._stageHeight;
      }

      public function set stageHeight(param1:Number) : void {
         this._stageHeight=param1;
         return;
      }

      private var _stageWidth:Number = 500;

      public function get stageWidth() : Number {
         return this._stageWidth;
      }

      public function set stageWidth(param1:Number) : void {
         this._stageWidth=param1;
         return;
      }

      protected function get barFrameRect() : RoundedRectangle {
         return new RoundedRectangle(14,40,154,4);
      }

      protected function get barRect() : RoundedRectangle {
         return new RoundedRectangle(14,39,154,6,0);
      }

      protected function get borderRect() : RoundedRectangle {
         return new RoundedRectangle(0,0,182,60,4);
      }

      private var _downloadingLabel:String = "Loading";

      protected function get downloadingLabel() : String {
         return this._downloadingLabel;
      }

      protected function set downloadingLabel(param1:String) : void {
         this._downloadingLabel=param1;
         return;
      }

      private var _label:String = "";

      protected function get label() : String {
         return this._label;
      }

      protected function set label(param1:String) : void {
         if(!(param1  is  Function))
         {
            this._label=param1;
         }
         this.draw();
         return;
      }

      protected function get labelFormat() : TextFormat {
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.color=3355443;
         _loc1_.font="Verdana";
         _loc1_.size=10;
         return _loc1_;
      }

      protected function get labelRect() : Rectangle {
         return new Rectangle(14,17,100,16);
      }

      protected function get percentFormat() : TextFormat {
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.align="right";
         _loc1_.color=0;
         _loc1_.font="Verdana";
         _loc1_.size=10;
         return _loc1_;
      }

      protected function get percentRect() : Rectangle {
         return new Rectangle(108,4,34,16);
      }

      private var _showLabel:Boolean = true;

      protected function get showLabel() : Boolean {
         return this._showLabel;
      }

      protected function set showLabel(param1:Boolean) : void {
         this._showLabel=param1;
         this.draw();
         return;
      }

      private var _showPercentage:Boolean = false;

      protected function get showPercentage() : Boolean {
         return this._showPercentage;
      }

      protected function set showPercentage(param1:Boolean) : void {
         this._showPercentage=param1;
         this.draw();
         return;
      }

      public function initialize() : void {
         this._startTime=getTimer();
         this.center(this.stageWidth,this.stageHeight);
         return;
      }

      protected function center(param1:Number, param2:Number) : void {
         this._xOffset=Math.floor((param1 - this._borderRect.width) / 2);
         this._yOffset=Math.floor((param2 - this._borderRect.height) / 2);
         return;
      }

      private function draw() : void {
         var _loc1_:* = NaN;
         if(this._startedLoading)
         {
            if(!this._startedInit)
            {
               _loc1_=Math.round(this.getPercentLoaded(this._value,this._maximum) * this.DOWNLOAD_PERCENTAGE / 100);
            }
            else
            {
               _loc1_=Math.round(this.getPercentLoaded(this._value,this._maximum) * (100 - this.DOWNLOAD_PERCENTAGE) / 100 + this.DOWNLOAD_PERCENTAGE);
            }
         }
         else
         {
            _loc1_=this.getPercentLoaded(this._value,this._maximum);
         }
         if(this._labelObj)
         {
            this._labelObj.text=this._label;
         }
         if(this._percentObj)
         {
            if(!this._showPercentage)
            {
               this._percentObj.visible=false;
               this._percentObj.text="";
            }
            else
            {
               this._percentObj.text=String(_loc1_) + "%";
            }
         }
         if((this._barSprite) && (this._barFrameSprite))
         {
            if(!this._showProgressBar)
            {
               this._barSprite.visible=false;
               this._barFrameSprite.visible=false;
            }
            else
            {
               this.drawProgressBar(_loc1_);
            }
         }
         return;
      }

      protected function createChildren() : void {
         var _loc2_:TextField = null;
         var _loc3_:TextField = null;
         var _loc1_:Graphics = graphics;
         if(this.backgroundColor != 4.294967295E9)
         {
            _loc1_.beginFill(this.backgroundColor,this.backgroundAlpha);
            _loc1_.drawRect(0,0,this.stageWidth,this.stageHeight);
         }
         if(this.backgroundImage != null)
         {
            this.loadBackgroundImage(this.backgroundImage);
         }
         this._barFrameSprite=new Sprite();
         this._barSprite=new Sprite();
         addChild(this._barFrameSprite);
         addChild(this._barSprite);
         _loc1_.beginFill(13421772,0.4);
         _loc1_.drawRoundRect(this.calcX(this._borderRect.x),this.calcY(this._borderRect.y),this._borderRect.width,this._borderRect.height,this._borderRect.cornerRadius * 2,this._borderRect.cornerRadius * 2);
         _loc1_.drawRoundRect(this.calcX(this._borderRect.x + 1),this.calcY(this._borderRect.y + 1),this._borderRect.width - 2,this._borderRect.height - 2,this._borderRect.cornerRadius - 1 * 2,this._borderRect.cornerRadius - 1 * 2);
         _loc1_.endFill();
         _loc1_.beginFill(13421772,0.4);
         _loc1_.drawRoundRect(this.calcX(this._borderRect.x + 1),this.calcY(this._borderRect.y + 1),this._borderRect.width - 2,this._borderRect.height - 2,this._borderRect.cornerRadius - 1 * 2,this._borderRect.cornerRadius - 1 * 2);
         _loc1_.endFill();
         var _loc4_:Graphics = this._barFrameSprite.graphics;
         var _loc5_:Matrix = new Matrix();
         _loc5_.createGradientBox(this._barFrameRect.width,this._barFrameRect.height,Math.PI / 2,this.calcX(this._barFrameRect.x),this.calcY(this._barFrameRect.y));
         _loc4_.beginGradientFill(GradientType.LINEAR,[6054502,11909306],[1,1],[0,255],_loc5_);
         _loc4_.drawRoundRect(this.calcX(this._barFrameRect.x),this.calcY(this._barFrameRect.y),this._barFrameRect.width,this._barFrameRect.height,this._barFrameRect.cornerRadius * 2,this._barFrameRect.cornerRadius * 2);
         _loc4_.drawRoundRect(this.calcX(this._barFrameRect.x + 1),this.calcY(this._barFrameRect.y + 1),this._barFrameRect.width - 2,this._barFrameRect.height - 2,this._barFrameRect.cornerRadius * 2,this._barFrameRect.cornerRadius * 2);
         _loc4_.endFill();
         this._labelObj=new TextField();
         this._labelObj.x=this.calcX(this._labelRect.x);
         this._labelObj.y=this.calcY(this._labelRect.y);
         this._labelObj.width=this._labelRect.width;
         this._labelObj.height=this._labelRect.height;
         this._labelObj.selectable=false;
         this._labelObj.defaultTextFormat=this.labelFormat;
         addChild(this._labelObj);
         this._percentObj=new TextField();
         this._percentObj.x=this.calcX(this._percentRect.x);
         this._percentObj.y=this.calcY(this._percentRect.y);
         this._percentObj.width=this._percentRect.width;
         this._percentObj.height=this._percentRect.height;
         this._percentObj.selectable=false;
         this._percentObj.defaultTextFormat=this.percentFormat;
         addChild(this._percentObj);
         var _loc6_:RectangularDropShadow = new RectangularDropShadow();
         _loc6_.color=0;
         _loc6_.angle=90;
         _loc6_.alpha=0.6;
         _loc6_.distance=2;
         _loc6_.tlRadius=_loc6_.trRadius=_loc6_.blRadius=_loc6_.brRadius=this._borderRect.cornerRadius;
         _loc6_.drawShadow(_loc1_,this.calcX(this._borderRect.x),this.calcY(this._borderRect.y),this._borderRect.width,this._borderRect.height);
         _loc1_.lineStyle(1,16777215,0.3);
         _loc1_.moveTo(this.calcX(this._borderRect.x) + this._borderRect.cornerRadius,this.calcY(this._borderRect.y));
         _loc1_.lineTo(this.calcX(this._borderRect.x) - this._borderRect.cornerRadius + this._borderRect.width,this.calcY(this._borderRect.y));
         return;
      }

      private function drawProgressBar(param1:Number) : void {
         var _loc11_:* = NaN;
         var _loc2_:Graphics = this._barSprite.graphics;
         _loc2_.clear();
         var _loc3_:Array = [16777215,16777215];
         var _loc4_:Array = [0,255];
         var _loc5_:Matrix = new Matrix();
         var _loc6_:Number = this._barRect.width * param1 / 100;
         var _loc7_:Number = _loc6_ / 2;
         var _loc8_:Number = this._barRect.height - 4;
         var _loc9_:Number = this.calcX(this._barRect.x);
         var _loc10_:Number = this.calcY(this._barRect.y) + 2;
         _loc5_.createGradientBox(_loc7_,_loc8_,0,_loc9_,_loc10_);
         _loc2_.beginGradientFill(GradientType.LINEAR,_loc3_,[0.39,0.85],_loc4_,_loc5_);
         _loc2_.drawRect(_loc9_,_loc10_,_loc7_,_loc8_);
         _loc5_.createGradientBox(_loc7_,_loc8_,0,_loc9_ + _loc7_,_loc10_);
         _loc2_.beginGradientFill(GradientType.LINEAR,_loc3_,[0.85,1],_loc4_,_loc5_);
         _loc2_.drawRect(_loc9_ + _loc7_,_loc10_,_loc7_,_loc8_);
         _loc7_=_loc6_ / 3;
         _loc8_=this._barRect.height;
         _loc10_=this.calcY(this._barRect.y);
         _loc11_=_loc10_ + _loc8_-1;
         _loc5_.createGradientBox(_loc7_,_loc8_,0,_loc9_,_loc10_);
         _loc2_.beginGradientFill(GradientType.LINEAR,_loc3_,[0.05,0.15],_loc4_,_loc5_);
         _loc2_.drawRect(_loc9_,_loc10_,_loc7_,1);
         _loc2_.drawRect(_loc9_,_loc11_,_loc7_,1);
         _loc5_.createGradientBox(_loc7_,_loc8_,0,_loc9_ + _loc7_,_loc10_);
         _loc2_.beginGradientFill(GradientType.LINEAR,_loc3_,[0.15,0.25],_loc4_,_loc5_);
         _loc2_.drawRect(_loc9_ + _loc7_,_loc10_,_loc7_,1);
         _loc2_.drawRect(_loc9_ + _loc7_,_loc11_,_loc7_,1);
         _loc5_.createGradientBox(_loc7_,_loc8_,0,_loc9_ + _loc7_ * 2,_loc10_);
         _loc2_.beginGradientFill(GradientType.LINEAR,_loc3_,[0.25,0.1],_loc4_,_loc5_);
         _loc2_.drawRect(_loc9_ + _loc7_ * 2,_loc10_,_loc7_,1);
         _loc2_.drawRect(_loc9_ + _loc7_ * 2,_loc11_,_loc7_,1);
         _loc7_=_loc6_ / 3;
         _loc8_=this._barRect.height;
         _loc10_=this.calcY(this._barRect.y) + 1;
         _loc11_=this.calcY(this._barRect.y) + _loc8_ - 2;
         _loc5_.createGradientBox(_loc7_,_loc8_,0,_loc9_,_loc10_);
         _loc2_.beginGradientFill(GradientType.LINEAR,_loc3_,[0.15,0.3],_loc4_,_loc5_);
         _loc2_.drawRect(_loc9_,_loc10_,_loc7_,1);
         _loc2_.drawRect(_loc9_,_loc11_,_loc7_,1);
         _loc5_.createGradientBox(_loc7_,_loc8_,0,_loc9_ + _loc7_,_loc10_);
         _loc2_.beginGradientFill(GradientType.LINEAR,_loc3_,[0.3,0.4],_loc4_,_loc5_);
         _loc2_.drawRect(_loc9_ + _loc7_,_loc10_,_loc7_,1);
         _loc2_.drawRect(_loc9_ + _loc7_,_loc11_,_loc7_,1);
         _loc5_.createGradientBox(_loc7_,_loc8_,0,_loc9_ + _loc7_ * 2,_loc10_);
         _loc2_.beginGradientFill(GradientType.LINEAR,_loc3_,[0.4,0.25],_loc4_,_loc5_);
         _loc2_.drawRect(_loc9_ + _loc7_ * 2,_loc10_,_loc7_,1);
         _loc2_.drawRect(_loc9_ + _loc7_ * 2,_loc11_,_loc7_,1);
         return;
      }

      protected function setProgress(param1:Number, param2:Number) : void {
         if(!isNaN(param1) && !isNaN(param2) && param1 >= 0 && param2 > 0)
         {
            this._value=Number(param1);
            this._maximum=Number(param2);
            this.draw();
         }
         return;
      }

      protected function getPercentLoaded(param1:Number, param2:Number) : Number {
         var _loc3_:* = NaN;
         if(param1 == 0 || param2 == 0 || (isNaN(param2)) || (isNaN(param1)))
         {
            return 0;
         }
         _loc3_=100 * param1 / param2;
         if((isNaN(_loc3_)) || _loc3_ <= 0)
         {
            return 0;
         }
         if(_loc3_ > 99)
         {
            return 99;
         }
         return Math.round(_loc3_);
      }

      private function show() : void {
         this._showingDisplay=true;
         this.calcScale();
         this.draw();
         this._displayTime=getTimer();
         return;
      }

      private function hide() : void {
         return;
      }

      private function calcX(param1:Number) : Number {
         return param1 + this._xOffset;
      }

      private function calcY(param1:Number) : Number {
         return param1 + this._yOffset;
      }

      private function calcScale() : void {
         var _loc1_:* = NaN;
         if(this.stageWidth < 160 || this.stageHeight < 120)
         {
            scaleX=1;
            scaleY=1;
         }
         else
         {
            if(this.stageWidth < 240 || this.stageHeight < 150)
            {
               this.createChildren();
               _loc1_=Math.min(this.stageWidth / 240,this.stageHeight / 150);
               scaleX=_loc1_;
               scaleY=_loc1_;
            }
            else
            {
               this.createChildren();
            }
         }
         return;
      }

      protected function showDisplayForDownloading(param1:int, param2:ProgressEvent) : Boolean {
         return param1 > 700 && param2.bytesLoaded < param2.bytesTotal / 2;
      }

      protected function showDisplayForInit(param1:int, param2:int) : Boolean {
         return param1 > 300 && param2 == 2;
      }

      private function loadBackgroundImage(param1:Object) : void {
         var _loc2_:Class = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:Loader = null;
         var _loc5_:LoaderContext = null;
         if((param1) && (param1 as Class))
         {
            _loc2_=Class(param1);
            this.initBackgroundImage(new _loc2_());
         }
         else
         {
            if((param1) && param1  is  String)
            {
               try
               {
                  _loc2_=Class(getDefinitionByName(String(param1)));
               }
               catch(e:Error)
               {
               }
               if(_loc2_)
               {
                  _loc3_=new _loc2_();
                  this.initBackgroundImage(_loc3_);
               }
               else
               {
                  _loc4_=new Loader();
                  _loc4_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loader_completeHandler);
                  _loc4_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.loader_ioErrorHandler);
                  _loc5_=new LoaderContext();
                  _loc5_.applicationDomain=new ApplicationDomain(ApplicationDomain.currentDomain);
                  _loc4_.load(new URLRequest(String(param1)),_loc5_);
               }
            }
         }
         return;
      }

      private function initBackgroundImage(param1:DisplayObject) : void {
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         addChildAt(param1,0);
         var _loc2_:Number = param1.width;
         var _loc3_:Number = param1.height;
         var _loc4_:Number = this.calcBackgroundSize();
         if(isNaN(_loc4_))
         {
            _loc7_=1;
            _loc8_=1;
         }
         else
         {
            _loc9_=_loc4_ * 0.01;
            _loc7_=_loc9_ * this.stageWidth / _loc2_;
            _loc8_=_loc9_ * this.stageHeight / _loc3_;
         }
         param1.scaleX=_loc7_;
         param1.scaleY=_loc8_;
         var _loc5_:Number = Math.round(0.5 * (this.stageWidth - _loc2_ * _loc7_));
         var _loc6_:Number = Math.round(0.5 * (this.stageHeight - _loc3_ * _loc8_));
         param1.x=_loc5_;
         param1.y=_loc6_;
         if(!isNaN(this.backgroundAlpha))
         {
            param1.alpha=this.backgroundAlpha;
         }
         return;
      }

      private function calcBackgroundSize() : Number {
         var _loc2_:* = 0;
         var _loc1_:Number = NaN;
         if(this.backgroundSize)
         {
            _loc2_=this.backgroundSize.indexOf("%");
            if(_loc2_ != -1)
            {
               _loc1_=Number(this.backgroundSize.substr(0,_loc2_));
            }
         }
         return _loc1_;
      }

      protected function progressHandler(param1:ProgressEvent) : void {
         var _loc2_:uint = param1.bytesLoaded;
         var _loc3_:uint = param1.bytesTotal;
         var _loc4_:int = getTimer() - this._startTime;
         if((this._showingDisplay) || (this.showDisplayForDownloading(_loc4_,param1)))
         {
            if(!this._startedLoading)
            {
               this.show();
               this.label=this.downloadingLabel;
               this._startedLoading=true;
            }
            this.setProgress(param1.bytesLoaded,param1.bytesTotal);
         }
         return;
      }

      protected function completeHandler(param1:Event) : void {
         return;
      }

      protected function rslProgressHandler(param1:RSLEvent) : void {
         return;
      }

      protected function rslCompleteHandler(param1:RSLEvent) : void {
         var _loc2_:* = "library";
         if(param1.isResourceModule)
         {
            _loc2_="module";
         }
         this.label="Loaded " + _loc2_ + " " + param1.rslIndex + " of " + param1.rslTotal;
         return;
      }

      protected function rslErrorHandler(param1:RSLEvent) : void {
         this._preloader.removeEventListener(ProgressEvent.PROGRESS,this.progressHandler);
         this._preloader.removeEventListener(Event.COMPLETE,this.completeHandler);
         this._preloader.removeEventListener(RSLEvent.RSL_PROGRESS,this.rslProgressHandler);
         this._preloader.removeEventListener(RSLEvent.RSL_COMPLETE,this.rslCompleteHandler);
         this._preloader.removeEventListener(RSLEvent.RSL_ERROR,this.rslErrorHandler);
         this._preloader.removeEventListener(FlexEvent.INIT_PROGRESS,this.initProgressHandler);
         this._preloader.removeEventListener(FlexEvent.INIT_COMPLETE,this.initCompleteHandler);
         if(!this._showingDisplay)
         {
            this.show();
            this._showingDisplay=true;
         }
         this.label="RSL Error " + (param1.rslIndex + 1) + " of " + param1.rslTotal;
         var _loc2_:ErrorField = new ErrorField(this);
         _loc2_.show(param1.errorText);
         return;
      }

      private function timerHandler(param1:Event=null) : void {
         dispatchEvent(new Event(Event.COMPLETE));
         return;
      }

      protected function initProgressHandler(param1:Event) : void {
         var _loc3_:* = NaN;
         var _loc2_:int = getTimer() - this._startTime;
         this._initProgressCount++;
         if(!this._showingDisplay && (this.showDisplayForInit(_loc2_,this._initProgressCount)))
         {
            this._displayStartCount=this._initProgressCount;
            this.show();
         }
         if(this._showingDisplay)
         {
            if(!this._startedInit)
            {
               this._startedInit=true;
               this.label=initializingLabel;
            }
            _loc3_=100 * this._initProgressCount / (this.initProgressTotal - this._displayStartCount);
            this.setProgress(Math.min(_loc3_,100),100);
         }
         return;
      }

      protected function initCompleteHandler(param1:Event) : void {
         var _loc3_:Timer = null;
         var _loc2_:int = getTimer() - this._displayTime;
         if((this._showingDisplay) && _loc2_ < this.MINIMUM_DISPLAY_TIME)
         {
            _loc3_=new Timer(this.MINIMUM_DISPLAY_TIME - _loc2_,1);
            _loc3_.addEventListener(TimerEvent.TIMER,this.timerHandler);
            _loc3_.start();
         }
         else
         {
            this.timerHandler();
         }
         return;
      }

      private function loader_completeHandler(param1:Event) : void {
         var _loc2_:DisplayObject = DisplayObject(LoaderInfo(param1.target).loader);
         this.initBackgroundImage(_loc2_);
         return;
      }

      private function loader_ioErrorHandler(param1:IOErrorEvent) : void {
         return;
      }
   }

}   import flash.display.Sprite;
   import mx.preloaders.DownloadProgressBar;
   import flash.text.TextFormat;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.system.Capabilities;


   class ErrorField extends Sprite
   {
      function ErrorField(param1:DownloadProgressBar) {
         super();
         this.downloadProgressBar=param1;
         return;
      }

      private var downloadProgressBar:DownloadProgressBar;

      private const MIN_WIDTH_INCHES:int = 2;

      private const MAX_WIDTH_INCHES:int = 6;

      private const TEXT_MARGIN_PX:int = 10;

      protected function get labelFormat() : TextFormat {
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.color=0;
         _loc1_.font="Verdana";
         _loc1_.size=10;
         return _loc1_;
      }

      public function show(param1:String) : void {
         if(param1 == null || param1.length == 0)
         {
            return;
         }
         var _loc2_:Number = this.downloadProgressBar.stageWidth;
         var _loc3_:Number = this.downloadProgressBar.stageHeight;
         var _loc4_:TextField = new TextField();
         _loc4_.autoSize=TextFieldAutoSize.LEFT;
         _loc4_.multiline=true;
         _loc4_.wordWrap=true;
         _loc4_.background=true;
         _loc4_.defaultTextFormat=this.labelFormat;
         _loc4_.text=param1;
         _loc4_.width=Math.max(this.MIN_WIDTH_INCHES * Capabilities.screenDPI,_loc2_ - this.TEXT_MARGIN_PX * 2);
         _loc4_.width=Math.min(this.MAX_WIDTH_INCHES * Capabilities.screenDPI,_loc4_.width);
         _loc4_.y=Math.max(0,_loc3_ - this.TEXT_MARGIN_PX - _loc4_.height);
         _loc4_.x=(_loc2_ - _loc4_.width) / 2;
         this.downloadProgressBar.parent.addChild(this);
         this.addChild(_loc4_);
         return;
      }
   }
