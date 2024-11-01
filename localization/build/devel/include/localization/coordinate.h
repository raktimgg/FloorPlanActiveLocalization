// Generated by gencpp from file localization/coordinate.msg
// DO NOT EDIT!


#ifndef LOCALIZATION_MESSAGE_COORDINATE_H
#define LOCALIZATION_MESSAGE_COORDINATE_H


#include <string>
#include <vector>
#include <memory>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace localization
{
template <class ContainerAllocator>
struct coordinate_
{
  typedef coordinate_<ContainerAllocator> Type;

  coordinate_()
    : x(0.0)
    , y(0.0)  {
    }
  coordinate_(const ContainerAllocator& _alloc)
    : x(0.0)
    , y(0.0)  {
  (void)_alloc;
    }



   typedef float _x_type;
  _x_type x;

   typedef float _y_type;
  _y_type y;





  typedef boost::shared_ptr< ::localization::coordinate_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::localization::coordinate_<ContainerAllocator> const> ConstPtr;

}; // struct coordinate_

typedef ::localization::coordinate_<std::allocator<void> > coordinate;

typedef boost::shared_ptr< ::localization::coordinate > coordinatePtr;
typedef boost::shared_ptr< ::localization::coordinate const> coordinateConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::localization::coordinate_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::localization::coordinate_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::localization::coordinate_<ContainerAllocator1> & lhs, const ::localization::coordinate_<ContainerAllocator2> & rhs)
{
  return lhs.x == rhs.x &&
    lhs.y == rhs.y;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::localization::coordinate_<ContainerAllocator1> & lhs, const ::localization::coordinate_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace localization

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::localization::coordinate_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::localization::coordinate_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::localization::coordinate_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::localization::coordinate_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::localization::coordinate_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::localization::coordinate_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::localization::coordinate_<ContainerAllocator> >
{
  static const char* value()
  {
    return "ff8d7d66dd3e4b731ef14a45d38888b6";
  }

  static const char* value(const ::localization::coordinate_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xff8d7d66dd3e4b73ULL;
  static const uint64_t static_value2 = 0x1ef14a45d38888b6ULL;
};

template<class ContainerAllocator>
struct DataType< ::localization::coordinate_<ContainerAllocator> >
{
  static const char* value()
  {
    return "localization/coordinate";
  }

  static const char* value(const ::localization::coordinate_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::localization::coordinate_<ContainerAllocator> >
{
  static const char* value()
  {
    return "float32 x\n"
"float32 y\n"
;
  }

  static const char* value(const ::localization::coordinate_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::localization::coordinate_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.x);
      stream.next(m.y);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct coordinate_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::localization::coordinate_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::localization::coordinate_<ContainerAllocator>& v)
  {
    s << indent << "x: ";
    Printer<float>::stream(s, indent + "  ", v.x);
    s << indent << "y: ";
    Printer<float>::stream(s, indent + "  ", v.y);
  }
};

} // namespace message_operations
} // namespace ros

#endif // LOCALIZATION_MESSAGE_COORDINATE_H
