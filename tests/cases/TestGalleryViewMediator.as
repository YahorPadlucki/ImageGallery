package cases
{
import cases.utils.SignalAsyncEvent;
import cases.utils.handleSignal;

import flash.events.MouseEvent;

import flexunit.framework.Assert;

import models.GalleryModel;
import models.vo.ImageVO;

import mx.collections.ArrayCollection;

import org.flexunit.async.Async;
import org.fluint.uiImpersonation.UIImpersonator;

import signals.ChangeImageSignal;
import signals.ImageFadedAwaySignal;
import signals.ImagesCollectionUpdatedSignal;

import spark.events.RendererExistenceEvent;

import views.mediators.GalleryViewMediator;
import views.ui.GalleryView;
import views.ui.renderer.ImageItemRenderer;

public class TestGalleryViewMediator
{
    private var _galleryView:GalleryView;
    private var _galleryViewMediator:GalleryViewMediator;
    private var _galleryModel:GalleryModel;

    private var _imageFadedAwaySignal:ImageFadedAwaySignal;
    private var _imagesCollectionUpdatedSignal:ImagesCollectionUpdatedSignal;
    private var _changeImageSignal:ChangeImageSignal;

    private var _testImagesArrayCollection:ArrayCollection;

    [Before(async, ui)]
    public function setUp():void
    {
        _galleryView = new GalleryView();
        _galleryModel = new GalleryModel();

       _testImagesArrayCollection = new ArrayCollection([new ImageVO(),new ImageVO(),new ImageVO]);

        _galleryView.dataProvider =_testImagesArrayCollection;

        _galleryViewMediator = new GalleryViewMediator();

        _imageFadedAwaySignal = new ImageFadedAwaySignal();
        _imagesCollectionUpdatedSignal = new ImagesCollectionUpdatedSignal();
        _changeImageSignal = new ChangeImageSignal();

        _galleryViewMediator.imageFadedAwaySignal = _imageFadedAwaySignal;
        _galleryViewMediator.imagesCollectionUpdatedSignal = _imagesCollectionUpdatedSignal;
        _galleryViewMediator.changeImageSignal = _changeImageSignal;

        _galleryViewMediator.galleryView = _galleryView;
        _galleryViewMediator.setViewComponent(_galleryView);

        _galleryViewMediator.onRegister();

        Async.proceedOnEvent(this, _galleryView, RendererExistenceEvent.RENDERER_ADD);
        UIImpersonator.addChild( _galleryView );
    }

    [Test]
    public function testViewSet():void
    {
        Assert.assertNotNull( _galleryViewMediator.galleryView );
        Assert.assertNotNull( _galleryViewMediator.getViewComponent() );
        Assert.assertEquals("Gallery view should have children ",_galleryViewMediator.galleryView.getItemIndicesInView().length>0,true);

    }

    [Test(async)]
    public function testImageChangeOnClick():void
    {
        var imageItemRenderer:ImageItemRenderer = ImageItemRenderer(_galleryViewMediator.galleryView.getElementAt(0));
        Assert.assertNotNull(imageItemRenderer);

        imageItemRenderer.imageFadedAwaySignal = _imageFadedAwaySignal;
        imageItemRenderer.image.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
        handleSignal(this,_galleryViewMediator.changeImageSignal,onChangeImageSignal);
    }

    private function onChangeImageSignal(event:SignalAsyncEvent, data:Object):void
    {
        Assert.assertEquals("Should change first image: ",_testImagesArrayCollection[0],event.args[0]);
    }


    [After(async, ui)]
    public function tearDown():void
    {
        _galleryView = null;
        _galleryViewMediator = null;
    }
}
}
