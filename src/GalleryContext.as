package {
import controller.LoadImagesCommand;

import models.GalleryModel;
import models.factory.IGalleryFactory;

import models.factory.LocalGalleryFactory;

import org.robotlegs.mvcs.SignalContext;

import servises.IGalleryImageService;
import servises.LocalImagesService;

import signals.ChangeImageSignal;

import signals.ImageFadedAwaySignal;
import signals.ImagesCollectionUpdatedSignal;
import signals.ImagesLoadingCompleteSignal;
import signals.LoadImagesSignal;

import views.mediators.GalleryViewMediator;

import views.ui.GalleryView;

public class GalleryContext extends  SignalContext
{
    private const VIEWS_PACKAGE_NAME:String ="views.ui";

    override public function startup():void
    {
        viewMap.mapPackage(VIEWS_PACKAGE_NAME);

        injector.mapSingleton(ImageFadedAwaySignal);
        injector.mapSingleton(ImagesCollectionUpdatedSignal);
        injector.mapSingleton(ImagesLoadingCompleteSignal);
        injector.mapSingleton(ChangeImageSignal);

        injector.mapSingletonOf( IGalleryImageService, LocalImagesService);

        injector.mapSingletonOf(IGalleryFactory,LocalGalleryFactory);

        injector.mapSingleton(GalleryModel);

        mediatorMap.mapView(GalleryView, GalleryViewMediator);

        LoadImagesSignal(signalCommandMap.mapSignalClass(LoadImagesSignal, LoadImagesCommand, true)).dispatch();
    }
}
}
