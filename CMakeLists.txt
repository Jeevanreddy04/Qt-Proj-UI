cmake_minimum_required(VERSION 3.16)
project(MartinGCS LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick QuickControls2)

qt_standard_project_setup()

qt_add_executable(appMartinGCS
    main.cpp
)

qt_add_qml_module(appMartinGCS
    URI GCSReplication
    VERSION 1.0
    QML_FILES
        Main.qml
        TopBar.qml
        LeftPanel.qml
        MapPanel.qml
        RightPanel.qml
        TelemetryBox.qml
)

target_link_libraries(appMartinGCS
    PRIVATE Qt6::Quick Qt6::QuickControls2
)

install(TARGETS appMartinGCS
    BUNDLE DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
