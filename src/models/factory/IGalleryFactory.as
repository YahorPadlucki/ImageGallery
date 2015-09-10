package models.factory
{
import mx.collections.ArrayCollection;

public interface IGalleryFactory
{
     function createImagesVOArrayListFromXMLList(input:XML, baseUrl:String=""):ArrayCollection
}
}
