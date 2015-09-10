package models.factory
{
import models.vo.ImageVO;

import mx.collections.ArrayCollection;

public class LocalGalleryFactory implements IGalleryFactory
{
    public function createImagesVOArrayListFromXMLList(input:XML, baseUrl:String=""):ArrayCollection
    {
        var imagesVOArrayList:ArrayCollection = new ArrayCollection();

        for each(var image:XML in input.children())
        {
            var imageVo:ImageVO = new ImageVO();

            imageVo.url=baseUrl + "images/" + image.@name + '.jpg';;

            imagesVOArrayList.addItem(imageVo);

        }

        return imagesVOArrayList;
    }
}
}
