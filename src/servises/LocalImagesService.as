package servises
{
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

import models.GalleryModel;
import models.factory.IGalleryFactory;

import mx.collections.ArrayCollection;

import org.robotlegs.mvcs.Actor;

import signals.ImagesLoadingCompleteSignal;

public class LocalImagesService extends Actor implements IGalleryImageService
{
    protected static const BASE_URL:String = "assets/";

    [Inject]
    public var _model:GalleryModel;

    [Inject]
    public var galleryFactory:IGalleryFactory;

    [Inject]
    public var imagesLoadingCompleteSignal:ImagesLoadingCompleteSignal;

    private var _loader:URLLoader = new URLLoader();

    public function loadImages():void
    {
        _loader.addEventListener(Event.COMPLETE, onLoaded);
        _loader.addEventListener(IOErrorEvent.IO_ERROR,onError);
        _loader.load(new URLRequest(BASE_URL+"gallery.xml"));
    }

    protected function onLoaded(event:Event):void
    {
        var imagesArrayCollection:ArrayCollection = galleryFactory.createImagesVOArrayListFromXMLList(new XML(event.target.data), BASE_URL);
        imagesLoadingCompleteSignal.dispatch(imagesArrayCollection);
    }

    protected function onError(event:Object):void
    {
        trace("Error loading gallery "+event);

    }
}
}
