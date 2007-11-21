# **********************************************************************
#
# Copyright (c) 2003-2007 ZeroC, Inc. All rights reserved.
#
# This copy of Ice is licensed to you under the terms described in the
# ICE_LICENSE file included in this distribution.
#
# **********************************************************************

top_srcdir	= ..\..

PKG		= icesl
LIBNAME		= $(PKG).dll
TARGETS		= $(bindir)\$(LIBNAME)

SRCS		= Application.cs \
		  Arrays.cs \
		  AssemblyInfo.cs \
		  AssemblyUtil.cs \
		  Base64.cs \
		  BasicStream.cs \
		  ByteBuffer.cs \
		  CollectionBase.cs \
		  CommunicatorI.cs \
		  Compare.cs \
		  DefaultsAndOverrides.cs \
		  DictionaryBase.cs \
		  EndpointFactory.cs \
		  EndpointFactoryManager.cs \
		  EndpointI.cs \
		  Exception.cs \
		  ImplicitContextI.cs \
		  Instance.cs \
		  LinkedList.cs \
		  LoggerI.cs \
		  Object.cs \
		  ObjectFactoryManager.cs \
		  Options.cs \
		  Outgoing.cs \
		  OutgoingAsync.cs \
		  OutgoingBase.cs \
		  OutputBase.cs \
		  Patcher.cs \
		  PropertiesI.cs \
		  Property.cs \
		  PropertyNames.cs \
		  Protocol.cs \
		  Proxy.cs \
		  ProxyFactory.cs \
		  ProxyIdentityKey.cs \
		  ReadObjectCallback.cs \
		  Reference.cs \
		  ReferenceFactory.cs \
		  ReplyStatus.cs \
		  Set.cs \
		  StringUtil.cs \
		  TcpEndpointI.cs \
		  Time.cs \
		  TraceLevels.cs \
		  UdpEndpointI.cs \
		  UnknownEndpointI.cs \
		  UserExceptionFactory.cs \
		  Util.cs \
		  ValueWriter.cs \
		  TraceUtil.cs

GEN_SRCS	= $(GDIR)\BuiltinSequences.cs \
		  $(GDIR)\Communicator.cs \
		  $(GDIR)\Endpoint.cs \
		  $(GDIR)\FacetMap.cs \
		  $(GDIR)\Identity.cs \
		  $(GDIR)\ImplicitContext.cs \
		  $(GDIR)\LocalException.cs \
		  $(GDIR)\Logger.cs \
		  $(GDIR)\ObjectFactory.cs \
		  $(GDIR)\Properties.cs \
		  $(GDIR)\Stats.cs \
		  $(GDIR)\Context.cs

SDIR		= $(slicedir)\Ice
GDIR		= generated

!include $(top_srcdir)\config\Make.rules.mak.cs

MCSFLAGS	= $(MCSFLAGS) -target:library -out:$(TARGETS) -warnaserror-
MCSFLAGS	= $(MCSFLAGS) -keyfile:$(top_srcdir)\config\IceslKey.snk

SLICE2SLFLAGS	= $(SLICE2SLFLAGS) --ice -I$(slicedir)

$(TARGETS):: $(SRCS) $(GEN_SRCS)
	$(MCS) $(MCSFLAGS) $(SRCS) $(GEN_SRCS)

!if "$(NOGAC)" == ""

install:: all
	$(GACUTIL) -i $(bindir)\$(LIBNAME)

!else

install:: all
	copy $(bindir)\icesl.dll $(install_bindir)

!endif

!include .depend