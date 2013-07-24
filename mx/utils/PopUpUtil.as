package mx.utils
{
   import flash.geom.Point;
   import flash.display.DisplayObject;
   import mx.managers.ISystemManager;
   import flash.geom.Rectangle;


   public class PopUpUtil extends Object
   {
      public function PopUpUtil() {
         super();
         return;
      }

      public static function positionOverComponent(param1:DisplayObject, param2:ISystemManager, param3:Number, param4:Number, param5:Number=NaN, param6:Point=null, param7:Point=null, param8:Boolean=true) : Point {
         var _loc13_:Point = null;
         var _loc14_:* = NaN;
         var _loc15_:Rectangle = null;
         var _loc16_:Point = null;
         var _loc17_:Point = null;
         var _loc9_:ISystemManager = param2.topLevelSystemManager;
         var _loc10_:DisplayObject = _loc9_.getSandboxRoot();
         var _loc11_:Number = 0;
         var _loc12_:Number = 0;
         if(param6)
         {
            _loc11_=param6.x;
            _loc12_=param6.y;
         }
         else
         {
            if(!param7)
            {
               param7=new Point(0,0);
            }
            _loc13_=_loc10_.globalToLocal(param1.localToGlobal(param7));
            _loc11_=_loc13_.x;
            _loc12_=_loc13_.y;
         }
         if(!isNaN(param5))
         {
            _loc14_=_loc10_.globalToLocal(param1.localToGlobal(new Point(0,param5))).y;
            _loc12_=_loc14_ - param4 / 2;
         }
         if(param8)
         {
            _loc15_=_loc9_.getVisibleApplicationRect(null,true);
            _loc16_=_loc10_.globalToLocal(_loc15_.topLeft);
            _loc17_=_loc10_.globalToLocal(_loc15_.bottomRight);
            _loc11_=Math.max(_loc16_.x,Math.min(_loc17_.x - param3,_loc11_));
            _loc12_=Math.max(_loc16_.y,Math.min(_loc17_.y - param4,_loc12_));
         }
         return new Point(_loc11_,_loc12_);
      }
   }

}