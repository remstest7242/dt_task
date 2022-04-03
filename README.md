# event_news_app_demo

## About App -

This app includes searching and show details based on Seat Geek API


## App Structure -

I have used get package for state management and followed structure based on that like below

Lib/core – this package includes core functionality related classed and packages like

Binding, network and route etc.

Lib/core/binding – this package includes binding (Dependency) related classes of app.

Lib/core/controller – this package includes controllers related classes of app.

Lib/core/data – this package includes constants of app.

Lib/core/model - this package includes model classes of app like API response classes of app.

Lib/core/network - this package includes network Utility and classes of app.

Lib/core/repository - this package includes network repository and classes of app.

Lib/core/routes - this package includes routes and classes of app.

Lib/core – this package includes screen related classed and packages.


## App Library -
cached_network_image - used for image catching

dio - used for networking

internet_connection_checker - used for checking internet

get - used for state management, routing, and dependency

lazy_load_scrollview - used for paging

path_provider - to store images for reusable

intl - used for formatting date


## App handles below scenario -
No internet handling page wise

No data handling page wise

Loader page wise

Lazy loading with search

Image catching

Image loader and placeholder

## Notes
I have tried concerned about logic, coding standard and make it easy to understand

I don't have ios devices as of now so I was unable to perform test and config for ios devices
