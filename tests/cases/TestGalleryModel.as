package cases
{
import cases.utils.SignalAsyncEvent;
import cases.utils.handleSignal;

import flexunit.framework.Assert;

import models.GalleryModel;
import models.vo.ImageVO;

import mx.collections.ArrayCollection;

import signals.ChangeImageSignal;

import signals.ImagesCollectionUpdatedSignal;

import signals.ImagesLoadingCompleteSignal;

public class TestGalleryModel
{
    private var _galleryModel:GalleryModel;
    private var _imagesLoadingCompleteSignal:ImagesLoadingCompleteSignal;
    private var _imagesCollectionUpdatedSignal:ImagesCollectionUpdatedSignal;
    private var _changeImageSignal:ChangeImageSignal;

    private var _imageVO:ImageVO;
    [Before]
    public function setUp():void
    {
        _galleryModel = new GalleryModel();
        _imagesLoadingCompleteSignal = new ImagesLoadingCompleteSignal();
        _imagesCollectionUpdatedSignal = new ImagesCollectionUpdatedSignal();
        _changeImageSignal = new ChangeImageSignal();

        _galleryModel.imagesLoadingCompleteSignal =_imagesLoadingCompleteSignal;
        _galleryModel.imagesCollectionUpdatedSignal =_imagesCollectionUpdatedSignal;
        _galleryModel.changeImageSignal=_changeImageSignal;
        _galleryModel.mapSignalListeners();

    }

    [Test(async)]
    public function testSetGallery():void
    {
        var imagesArrayCollection:ArrayCollection = new ArrayCollection();
        imagesArrayCollection.addItem(new ImageVO());
        handleSignal(this,_galleryModel.imagesCollectionUpdatedSignal,onImagesCollectionLoadedTest);

        _imagesLoadingCompleteSignal.dispatch(imagesArrayCollection);

    }

    private function onImagesCollectionLoadedTest(event:SignalAsyncEvent, data:Object):void
    {
        Assert.assertEquals("No images found", _galleryModel.images.length >0, true );
    }

    [Test(async)]
    public function testChangeImage():void
    {
        var imagesArrayCollection:ArrayCollection = new ArrayCollection();
        _imageVO = new ImageVO();
        _imageVO.url = "1";

        var imageVO2:ImageVO = new ImageVO();
        imageVO2.url="2";

        imagesArrayCollection.addItem(_imageVO);
        imagesArrayCollection.addItem(imageVO2);

        handleSignal(this,_galleryModel.imagesCollectionUpdatedSignal,onImagesCollectionLoaded);
        _imagesLoadingCompleteSignal.dispatch(imagesArrayCollection);

    }

    private function onImagesCollectionLoaded(event:SignalAsyncEvent, data:Object):void
    {
        handleSignal(this,_galleryModel.imagesCollectionUpdatedSignal,onImagesCollectionChanged);
        _changeImageSignal.dispatch(_imageVO);
    }

    private function onImagesCollectionChanged(event:SignalAsyncEvent, data:Object):void
    {
        Assert.assertNotContained("shouldn't be equal: ", _imageVO.url,_galleryModel.images[0].url)
    }

    [After]
    public function tearDown():void
    {
        _galleryModel = null;
    }
}
}
