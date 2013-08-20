/** * <p>Original Author: Daniel Freeman</p> * * <p>Permission is hereby granted, free of charge, to any person obtaining a copy * of this software and associated documentation files (the "Software"), to deal * in the Software without restriction, including without limitation the rights * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell * copies of the Software, and to permit persons to whom the Software is * furnished to do so, subject to the following conditions:</p> * * <p>The above copyright notice and this permission notice shall be included in * all copies or substantial portions of the Software.</p> * * <p>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE * AUTHORS' OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN * THE SOFTWARE.</p> * * <p>Licensed under The MIT License</p> * <p>Redistributions of files must retain the above copyright notice.</p> */package asfiles {		import flash.display.Sprite;	import flash.events.MouseEvent;	import flash.geom.ColorTransform;	import flash.geom.Rectangle;		public class MyButton extends Sprite {				protected const koncol:uint=0x666666;		protected const koffcol:uint=0x999999;		public const greyout:uint=0xeeeeee;				public var oncol:uint;		public var offcol:uint;		private var hint:String;		public var broadcast:Boolean=false;		protected var id:String;				public function MyButton(stage:Sprite,xx:int,yy:int,hint:String=null,offcol:uint=koffcol,id:String=null,oncol:uint=koncol) {			stage.addChild(this);x=xx;y=yy;this.offcol=offcol;this.oncol=oncol;this.hint=hint;			if (id!=null) {this.id=id;broadcast=true;}			redraw();makebutton();			addEventListener(MouseEvent.MOUSE_OVER,mouseover);					addEventListener(MouseEvent.MOUSE_DOWN,pressed);			addEventListener(MouseEvent.MOUSE_OUT,released);			addEventListener(MouseEvent.MOUSE_UP,mouseup);			colour(oncol);colour(offcol);			}					private function makebutton():void {			var rect:Rectangle=getRect(this);			hitArea=new Sprite();			hitArea.graphics.beginFill(0,0);			hitArea.graphics.drawRect(rect.x,rect.y,rect.width,rect.height);			addChild(hitArea);grey=hitArea.mouseEnabled=false;colour(offcol);			}					public function redraw(colour:uint = 0):void {		}				protected function colour(col:uint):void {			transform.colorTransform = new ColorTransform((col>>16 & 0xff)/256,(col>>8 & 0xff)/256,(col & 0xff)/256);		}				protected function pressed(ev:MouseEvent=null):void {			if (hint!=null) Cursor.delayhint(stage);			colour(grey ? greyout : oncol);		}				public function mouseup(ev:MouseEvent):void {			if (broadcast) stage.dispatchEvent(new MyEvent(id));			released(ev);		}				protected function released(ev:MouseEvent=null):void {			if (hint!=null && stage!=null) Cursor.delayhint(stage);			colour(grey ? greyout : offcol);		}				public function set grey(st:Boolean):void {			useHandCursor=buttonMode=!st;		}				public function get grey():Boolean {			return !useHandCursor;		}				public function mouseover(ev:MouseEvent):void {			if (hint!=null) Cursor.delayhint(stage,hint);		}						public function destructor():void		{			removeEventListener(MouseEvent.MOUSE_OVER,mouseover);					removeEventListener(MouseEvent.MOUSE_DOWN,pressed);			removeEventListener(MouseEvent.MOUSE_OUT,released);			removeEventListener(MouseEvent.MOUSE_UP,mouseup);		}			}	}