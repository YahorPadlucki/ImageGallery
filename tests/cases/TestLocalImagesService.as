package cases
{
import flexunit.framework.Assert;

import models.factory.LocalGalleryFactory;

import cases.utils.SignalAsyncEvent;

import cases.utils.handleSignal;


import servises.LocalImagesService;

import signals.ImagesLoadingCompleteSignal;

public class TestLocalImagesService
{
    private var _service:LocalImagesService;

    [Before]
    public function setUp():void
    {
        _service = new LocalImagesService();
        _service.imagesLoadingCompleteSignal = new ImagesLoadingCompleteSignal();
        _service.galleryFactory = new LocalGalleryFactory();
    }

    [Test(async)]
    public function testLoadAndParseImages():void
    {
        handleSignal(this,_service.imagesLoadingCompleteSignal,onImagesLoadingComplete);
        _service.loadImages();
    }

    private function onImagesLoadingComplete(event:SignalAsyncEvent, data:Object):void
    {
        Assert.assertEquals("No images loaded: ", event.args[0].length > 0, true)
    }

    [After]
    public function tearDown():void
    {
        _service = null;
    }
}
}
