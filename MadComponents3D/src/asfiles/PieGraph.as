﻿/** * <p>Original Author: Daniel Freeman</p> * * <p>Permission is hereby granted, free of charge, to any person obtaining a copy * of this software and associated documentation files (the "Software"), to deal * in the Software without restriction, including without limitation the rights * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell * copies of the Software, and to permit persons to whom the Software is * furnished to do so, subject to the following conditions:</p> * * <p>The above copyright notice and this permission notice shall be included in * all copies or substantial portions of the Software.</p> * * <p>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE * AUTHORS' OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN * THE SOFTWARE.</p> * * <p>Licensed under The MIT License</p> * <p>Redistributions of files must retain the above copyright notice.</p> */package asfiles {		import flash.display.Sprite;	import flash.ui.Mouse;	import flash.events.MouseEvent;	import flash.text.TextFormat;	import flash.text.TextFieldAutoSize;	import flash.utils.ByteArray;	public class PieGraph extends GraphPalette {				private const msgformat:TextFormat=new TextFormat('Arial',14,0x333399);		private var segs:Array = [];		private var errmsg:PrintAt;		public function PieGraph(screen:Sprite,xx:int,yy:int,select:Packet,ss:*=null,freq:Boolean=false) {		errmsg=new PrintAt(this,wdth/2,hght/2,'invalid data',TextFieldAutoSize.CENTER,msgformat);		iam=1;super(screen,xx,yy,select,ss,freq);	//	controls=new GraphControls(this,frame/2,frame/2,freq ? 'frequency pie chart' : 'pie chart',false,true);		this.threed=true;		resize(wdth,hght);	//	controls.addEventListener(MouseEvent.CLICK,controlsclick);		}								override public function resize(wdth:int,hght:int):void {			scale.visible=gridbe.visible=drawax.visible=false;			myheight=hght-controlsoffset(wdth,hght)-frame;			mywidth=wdth-frame;			grph.x=frame/2;			grph.y=frame/2+controlsoffset(wdth,hght)+4;			bgredraw();		}				override public function drawscale(screen:Sprite):void {		}						override public function gridbehind():void {		}						override public function drawaxis():void {		}						override public function darefresh(ev:*=null):void {			maxandmin();			bgredraw();		}						private function cellobj(n:int):Cell {			var i:int=(datai==1) ? 0 : n;			var j:int=(dataj==1) ? 0 : n;			if (freq) return null;			else return readcell(i,j);		}		private function cellvalue(n:int):Number {			var cell:Cell;			if (freq) if (frequencybin==null || frequencybin.length==0) return 0; else if (frequencybin[0].length>1) return frequencybin[0][n]; else return frequencybin[n][0];			else if ((cell=cellobj(n))==null || !cell.isvalue) return 0; else 				if (isNaN(cell.value)) return 0; else return cell.value;		}						private function errmessage():void {			errmsg.visible=true;			errmsg.x=(wdth-errmsg.width)/2;			errmsg.y=(hght-errmsg.height)/2;			for (var i:int=0;i<segs.length;i++) segs[i].visible=false;		}						private function clear():void {			for (var i:int=0;i<segs.length;i++) if (segs[i]!=null) segs[i].destructor();			segs=[];		}				override public function bgredraw():void {			var posn:Number;			var total:Number=0;			var share:Number;			if (freq) clear();			if (max==0||min<0||(datai>1 && dataj>1)) errmessage();			else {				for (var j:int=0;j<no;j++) total+=cellvalue(j);				if (total==0) errmessage();				else {					errmsg.visible=false;					share=2*Math.PI/total;					posn=0;					for (var i:int=0;i<no;i++) {						if (segs[i]==null) segs[i]=new Segment(grph);						segs[i].visible=true;						posn=segs[i].plotseg(mywidth,myheight,(datai==1) ? colour(0,i) : colour(i),posn,cellobj(i),share,threed,freq ? cellvalue(i) : -1,frequencylabel(i));					}				}			}		}	}}