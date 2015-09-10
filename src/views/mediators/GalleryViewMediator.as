package views.mediators
{
import models.GalleryModel;
import models.vo.ImageVO;

import org.robotlegs.mvcs.Mediator;

import signals.ChangeImageSignal;
import signals.ImageFadedAwaySignal;
import signals.ImagesCollectionUpdatedSignal;

import views.ui.GalleryView;

public class GalleryViewMediator extends Mediator
{
    [Inject]
    public var galleryView:GalleryView;
    [Inject]
    public var _model:GalleryModel;

    [Inject]
    public var imageFadedAwaySignal:ImageFadedAwaySignal;
    [Inject]
    public var imagesCollectionUpdatedSignal:ImagesCollectionUpdatedSignal;
    [Inject]
    public var changeImageSignal:ChangeImageSignal;


    override public function onRegister():void
    {
        imageFadedAwaySignal.add(onImageFadedAway);
        imagesCollectionUpdatedSignal.add(onImagesCollectionUpdated);
    }


    private function onImageFadedAway(imageVO:ImageVO):void
    {
        changeImageSignal.dispatch(imageVO);
    }

    private function onImagesCollectionUpdated():void
    {
        galleryView.dataProvider = _model.images;
    }

}
}
