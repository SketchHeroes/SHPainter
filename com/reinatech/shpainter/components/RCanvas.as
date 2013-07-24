package com.reinatech.shpainter.components
{
   import mx.containers.Canvas;


   public class RCanvas extends Canvas
   {
      public function RCanvas() {
         super();
         return;
      }

      private var arrListeners:Array;

      override public function addEventListener(param1:String, param2:Function, param3:Boolean=false, param4:int=0, param5:Boolean=false) : void {
         super.addEventListener(param1,param2,param3,param4,param5);
         if(!this.arrListeners)
         {
            this.arrListeners=new Array();
         }
         this.arrListeners.push(
            {
               "type":param1,
               "listener":param2
            }
         );
         return;
      }

      public function clearEvents() : void {
         if(!this.arrListeners)
         {
            return;
         }
         var _loc1_:* = 0;
         while(_loc1_ < this.arrListeners.length)
         {
            if(this.hasEventListener(this.arrListeners[_loc1_].type))
            {
               this.removeEventListener(this.arrListeners[_loc1_].type,this.arrListeners[_loc1_].listener);
            }
            _loc1_++;
         }
         this.arrListeners=null;
         return;
      }
   }

}