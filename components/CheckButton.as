package components
{
   import flash.display.Sprite;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.events.Event;
   import flash.text.TextField;


   public class CheckButton extends Sprite
   {
      public function CheckButton(param1:MovieClip, param2:String, param3:Boolean) {
         super();
         this._state=param3;
         this._text=param2;
         this._template=param1;
         this._template.stop();
         this.update();
         if((this._template) && "button"  in  this._template)
         {
            this._button=this._template["button"] as SimpleButton;
            if(this._button)
            {
               this._button.addEventListener(MouseEvent.CLICK,this.onClick);
            }
         }
         return;
      }

      private var _template:MovieClip;

      private var _text:String;

      private var _state:Boolean;

      private var _button:SimpleButton;

      private function onClick(param1:MouseEvent) : void {
         this.state=!this._state;
         dispatchEvent(new Event(Event.CHANGE,true,false));
         return;
      }

      public function get state() : Boolean {
         return this._state;
      }

      public function set state(param1:Boolean) : void {
         this._state=param1;
         this.update();
         return;
      }

      private function update() : void {
         this._template.gotoAndStop(this._state?1:2);
         if((this._template) && "text"  in  this._template)
         {
            (this._template["text"] as TextField).text=this._text;
         }
         return;
      }
   }

}