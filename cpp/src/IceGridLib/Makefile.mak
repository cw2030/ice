# **********************************************************************
#
# Copyright (c) 2003-2007 ZeroC, Inc. All rights reserved.
#
# This copy of Ice is licensed to you under the terms described in the
# ICE_LICENSE file included in this distribution.
#
# **********************************************************************

top_srcdir	= ..\..

LIBNAME		= $(top_srcdir)\lib\icegrid$(LIBSUFFIX).lib
DLLNAME		= $(top_srcdir)\bin\icegrid$(SOVERSION)$(LIBSUFFIX).dll

TARGETS         = $(LIBNAME) $(DLLNAME)

LIB_OBJS	= Admin.obj \
		  Locator.obj \
		  Query.obj \
		  Exception.obj \
		  Descriptor.obj \
                  FileParser.obj \
		  Observer.obj \
		  Session.obj \
		  Registry.obj \
		  UserAccountMapper.obj

SRCS		= $(LIB_OBJS:.obj=.cpp)

HDIR		= $(includedir)\IceGrid
SDIR		= $(slicedir)\IceGrid

!include $(top_srcdir)\config\Make.rules.mak

LINKWITH 	= $(LIBS) glacier2$(LIBSUFFIX).lib

SLICE2CPPFLAGS	= --checksum --ice --include-dir IceGrid --dll-export ICE_GRID_API $(SLICE2CPPFLAGS)
CPPFLAGS        = -I.. -DICE_GRID_API_EXPORTS $(CPPFLAGS)

!if "$(GENERATE_PDB)" == "yes"
PDBFLAGS        = /pdb:$(DLLNAME:.dll=.pdb)
!endif

$(LIBNAME): $(DLLNAME)

$(DLLNAME): $(LIB_OBJS) IceGrid.res
	$(LINK) $(LD_DLLFLAGS) $(PDBFLAGS) $(LIB_OBJS) IceGrid.res $(PREOUT)$@ $(PRELIBS)$(LINKWITH)
	move $(DLLNAME:.dll=.lib) $(LIBNAME)
	@if exist $@.manifest echo ^ ^ ^ Embedding manifest using $(MT) && \
	    $(MT) -nologo -manifest $@.manifest -outputresource:$@;#2 && del /q $@.manifest
	@if exist $(DLLNAME:.dll=.exp) del /q $(DLLNAME:.dll=.exp)

IceGrid.res: IceGrid.rc
	rc.exe $(RCFLAGS) IceGrid.rc
clean::
	del /q Admin.cpp $(HDIR)\Admin.h
	del /q Descriptor.cpp $(HDIR)\Descriptor.h
	del /q Exception.cpp $(HDIR)\Exception.h
	del /q Locator.cpp $(HDIR)\Locator.h
	del /q Observer.cpp $(HDIR)\Observer.h
	del /q Query.cpp $(HDIR)\Query.h
	del /q Session.cpp $(HDIR)\Session.h
	del /q Registry.cpp $(HDIR)\Registry.h
	del /q UserAccountMapper.cpp $(HDIR)\UserAccountMapper.h
	del /q $(DLLNAME:.dll=.*)
	del /q IceGrid.res

install:: all
	copy $(LIBNAME) $(install_libdir)
	copy $(DLLNAME) $(install_bindir)

!if "$(OPTIMIZE)" != "yes"

!if "$(CPP_COMPILER)" == "BCC2006"

install:: all
	copy $(DLLNAME:.dll=.tds) $(install_bindir)

!else

install:: all
	copy $(DLLNAME:.dll=.pdb) $(install_bindir)

!endif

!endif

!include .depend