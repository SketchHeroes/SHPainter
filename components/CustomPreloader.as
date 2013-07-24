package components
{
   import mx.preloaders.DownloadProgressBar;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.system.Security;
   import flash.net.URLRequestMethod;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.net.URLVariables;
   import flash.net.URLRequest;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.external.ExternalInterface;
   import mx.events.FlexEvent;


   public class CustomPreloader extends DownloadProgressBar
   {
      public function CustomPreloader() {
         super();
         return;
      }

      private var loader:Loader;

      private var adv:Sprite;

      private var ticTacTiObj:Object;

      private var _bAdvComplete:Boolean = false;

      private var _bEngineReady:Boolean = false;

      override public function initialize() : void {
         super.initialize();
         Security.allowDomain("*");
         var _loc1_:Number = 3170;
         var _loc2_:* = "cleanapi";
         var _loc3_:* = "flash_video_player";
         var _loc4_:* = "-1952520052";
         this.adv=new Sprite();
         addChild(this.adv);
         this.loadTicTacTiSwf("http://pro.tictacti.com/" + _loc1_ + "/" + _loc2_ + ".t3f?publisherId=" + _loc1_ + "&tagType=" + _loc2_ + "&engineId=" + _loc3_ + "&MediaPlayerType=5&externalId=" + _loc4_ + "&CurrentPlayedMovie=SHPlayer",-1,this.onEngineLoaded,this.adv,URLRequestMethod.GET);
         return;
      }

      public function loadTicTacTiSwf(param1:String, param2:int, param3:Function, param4:DisplayObjectContainer, param5:String=null, param6:URLVariables=null) : DisplayObject {
         var _loc7_:Loader = new Loader();
         var _loc8_:URLRequest = new URLRequest(param1);
         if(param5 != null)
         {
            _loc8_.method=param5;
         }
         if(param6 != null)
         {
            _loc8_.data=param6;
         }
         _loc7_.contentLoaderInfo.addEventListener(Event.COMPLETE,param3);
         _loc7_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,param3);
         _loc7_.load(_loc8_);
         if(param4 != null)
         {
            if(param2 < 0)
            {
               param4.addChild(_loc7_);
            }
            else
            {
               param4.addChildAt(_loc7_,param2);
            }
         }
         return _loc7_;
      }

      protected function onEngineLoaded(param1:Event) : void {
         if(param1.type == IOErrorEvent.IO_ERROR)
         {
            return;
         }
         var _loc2_:* = param1.target.content;
         _loc2_.Init();
         this.ticTacTiObj=_loc2_.EngineObj;
         this.ticTacTiObj.addEventListener("INIT_DONE",this.onEngineReady);
         this.ticTacTiObj.addEventListener("AD_CLOSED",this.onAdClosed);
         return;
      }

      private function onAdClosed(param1:Event) : void {
         this._bAdvComplete=true;
         this.checkPreloaderComplete();
         this.adv.visible=false;
         this.adv.height=0;
         return;
      }

      private function onEngineReady(param1:Event) : void {
         this._bEngineReady=true;
         if(ExternalInterface.available)
         {
            this.ticTacTiObj.APIGameConnector.ShowPreRoll();
         }
         else
         {
            this.onAdClosed(null);
         }
         this.checkPreloaderComplete();
         return;
      }

      private function checkPreloaderComplete() : void {
         if((this._bAdvComplete) && (this._bEngineReady))
         {
            this.dispatchEvent(new Event(Event.COMPLETE));
         }
         return;
      }

      override public function set preloader(param1:Sprite) : void {
         param1.addEventListener(FlexEvent.INIT_COMPLETE,this.FlexInitComplete);
         return;
      }

      private function FlexInitComplete(param1:Event) : void {
         return;
      }
   }

}