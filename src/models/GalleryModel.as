package models
{
import models.vo.ImageVO;

import mx.collections.ArrayCollection;

import signals.ChangeImageSignal;

import signals.ImagesCollectionUpdatedSignal;
import signals.ImagesLoadingCompleteSignal;

public class GalleryModel
{
    [Inject]
    public var imagesCollectionUpdatedSignal:ImagesCollectionUpdatedSignal;
    [Inject]
    public var imagesLoadingCompleteSignal:ImagesLoadingCompleteSignal;
    [Inject]
    public var changeImageSignal:ChangeImageSignal;

    private var _imagesArrayCollection:ArrayCollection = new ArrayCollection();

    [PostConstruct]
    public function mapSignalListeners():void
    {
        imagesLoadingCompleteSignal.add(onImagesLoaded);
        changeImageSignal.add(onChangeImageSignal);
    }




    public function get images():ArrayCollection
    {
        return _imagesArrayCollection;
    }

    private function onChangeImageSignal(imageVOToChange:ImageVO):void
    {
        var imageToChangeIndex:int = _imagesArrayCollection.getItemIndex(imageVOToChange);
        _imagesArrayCollection.removeItemAt(imageToChangeIndex);
        _imagesArrayCollection.addItemAt(getNewRandomImageVO(imageVOToChange.url), imageToChangeIndex);

        imagesCollectionUpdatedSignal.dispatch();
    }

    private function onImagesLoaded(imagesVoArrayCollection:ArrayCollection):void
    {
        _imagesArrayCollection = imagesVoArrayCollection;

        imagesCollectionUpdatedSignal.dispatch();
    }


    private function getNewRandomImageVO(changedImageUrl:String):ImageVO
    {
        var newImageVO:ImageVO = new ImageVO();

         var shuffledImagesArrayCollection:ArrayCollection =   getShuffledImagesArrayCollection();
        for each (var imageVO:ImageVO in shuffledImagesArrayCollection)
        {
            if (imageVO.url != changedImageUrl)
            {
                newImageVO.url = imageVO.url;
                break;
            }
        }

        return newImageVO;
    }

    private function getShuffledImagesArrayCollection( ) : ArrayCollection
    {
        var newCollection:ArrayCollection = new ArrayCollection( _imagesArrayCollection.toArray() );

        for(var a:int = 0; a < newCollection.length; a++){
            var imageVO:ImageVO = newCollection[a];
            var b:int = Math.floor(Math.random() * newCollection.length);
            newCollection[a] = newCollection[b];
            newCollection[b] = imageVO;
        }
        return newCollection;
    }
}
}
