////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package org.apache.flex.flat.beads
{
	
    import org.apache.flex.core.IBead;
	import org.apache.flex.core.IBeadLayout;
	import org.apache.flex.core.IBeadView;
	import org.apache.flex.core.IScrollBarModel;
	import org.apache.flex.core.IStrand;
	import org.apache.flex.core.IUIBase;
	import org.apache.flex.core.Strand;
	import org.apache.flex.core.UIBase;
	import org.apache.flex.core.ValuesManager;
    import org.apache.flex.events.IEventDispatcher;
    import org.apache.flex.events.Event;
	import org.apache.flex.html.Button;
	import org.apache.flex.html.beads.controllers.ButtonAutoRepeatController;
    import org.apache.flex.html.beads.IScrollBarView;

    /**
     *  The ScrollBarView class is the default view for
     *  the org.apache.flex.html.supportClasses.ScrollBar class.
     *  It implements the classic desktop-like ScrollBar.
     *  A different view would implement more modern scrollbars that hide themselves
     *  until hovered over with the mouse.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion FlexJS 0.0
     */
	public class CSSScrollBarView extends Strand implements IBeadView, IStrand, IScrollBarView
	{
        /**
         *  Constructor.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
		public function CSSScrollBarView()
		{
		}
				
		private var sbModel:IScrollBarModel;
		
		private var _strand:IStrand;
		
        /**
         *  The layout. 
         * 
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
        private var layout:IBeadLayout;
        
        /**
         *  The host component. 
         * 
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
        public function get host():IUIBase
        {
            return _strand as IUIBase;
        }

        /**
         *  @copy org.apache.flex.core.IBead#strand
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
		public function set strand(value:IStrand):void
		{
			_strand = value;
            
            for each (var bead:IBead in beads)
                addBead(bead);
            
            var host:UIBase = UIBase(value);
			sbModel = value.getBeadByType(IScrollBarModel) as IScrollBarModel;
            sbModel = _strand.getBeadByType(IScrollBarModel) as IScrollBarModel;
            sbModel.addEventListener("maximumChange", changeHandler);
            sbModel.addEventListener("minimumChange", changeHandler);
            sbModel.addEventListener("snapIntervalChange", changeHandler);
            sbModel.addEventListener("stepSizeChange", changeHandler);
            sbModel.addEventListener("pageSizeChange", changeHandler);
            sbModel.addEventListener("valueChange", changeHandler);
            
            // TODO: (aharui) put in values impl
			_increment = new Button();
            Button(_increment).className = "vscrollbar-downarrow-btn";
            var sbView:CSSScrollBarButtonView = new CSSScrollBarButtonView();
            sbView.upArrowShape.className = "vscrollbar-downarrow";
            sbView.downArrowShape.className = "vscrollbar-downarrow";
            sbView.overArrowShape.className = "vscrollbar-downarrow";
            _increment.addBead(sbView);
            _increment.addBead(new ButtonAutoRepeatController());
			_decrement = new Button();
            _decrement.className = "vscrollbar-uparrow-btn";
            sbView = new CSSScrollBarButtonView();
            sbView.upArrowShape.className = "vscrollbar-uparrow";
            sbView.downArrowShape.className = "vscrollbar-uparrow";
            sbView.overArrowShape.className = "vscrollbar-uparrow";
            _decrement.addBead(sbView);
            _decrement.addBead(new ButtonAutoRepeatController());
			_track = new Button();
            _track.className = "vscrollbar-track";
			_thumb = new Button();				
            _thumb.className = "vscrollbar-thumb";
            
            host.addElement(_decrement);
            host.addElement(_increment);
            host.addElement(_track);
            host.addElement(_thumb);
            
            IEventDispatcher(_strand).addEventListener("heightChanged", changeHandler);
            
            if( _strand.getBeadByType(IBeadLayout) == null ) {
                layout = new (ValuesManager.valuesImpl.getValue(_strand, "iBeadLayout")) as IBeadLayout;
                _strand.addBead(layout);
            }
            layout.layout();
		}
						
        private function changeHandler(event:Event):void
        {
            layout.layout();    
        }
        
		private var _decrement:Button;
		private var _increment:Button;
		private var _track:Button;
		private var _thumb:Button;
		
        /**
         *  @copy org.apache.flex.html.beads.IScrollBarView#decrement
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
		public function get decrement():Button
		{
			return _decrement;
		}

        /**
         *  @copy org.apache.flex.html.beads.IScrollBarView#increment
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
		public function get increment():Button
		{
			return _increment;
		}
        
        /**
         *  @copy org.apache.flex.html.beads.IScrollBarView#track
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
		public function get track():Button
		{
			return _track;
		}
        
        /**
         *  @copy org.apache.flex.html.beads.IScrollBarView#thumb
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
		public function get thumb():Button
		{
			return _thumb;
		}
		
        /**
         *  @copy org.apache.flex.core.IBeadView#viewHeight
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
        public function get viewHeight():Number
        {
            // don't want to put $height in an interface
            return _strand["$height"];
        }
        
        /**
         *  @copy org.apache.flex.core.IBeadView#viewWidth
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
        public function get viewWidth():Number
        {
            // don't want to put $width in an interface
            return _strand["$width"];
        }
	}
}
